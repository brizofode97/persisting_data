import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:persisting_data/data/sembast_codec.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import '../models/password.dart';

class SembastDb {
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database? _db;
  final store = intMapStoreFactory.store('passwords');

  static SembastDb? _singleton;

  var codec = getEncryptSembastCodec(password: 'password');

  SembastDb._internal();

  factory SembastDb() {
    _singleton ??= SembastDb._internal();
    return _singleton as SembastDb;
  }

  Future<Database> init() async {
    _db ??= await _openDb();
    return _db!;
  }

  // ignore: unused_element
  Future<Database> _openDb() async {
    final docsDir = await getApplicationDocumentsDirectory();
    print(getApplicationDocumentsDirectory());
    final dbPath = join(docsDir.path, 'pass.db');
    final db = dbFactory.openDatabase(dbPath, codec: codec);
    return db;
  }

  Future<int> addPassword(Password password) async {
    int id = await store.add(_db!, password.toJson());
    return id;
  }

  Future<List<Password>> readPassword() async {
    await init();

    final finder = Finder(sortOrders: [SortOrder('name')]);

    final snapshot = await store.find(_db!, finder: finder);

    return snapshot.map((item) {
      Password pwd = Password.fromJson(item.value);
      pwd.id = item.key;
      return pwd;
    }).toList();
  }

  Future updatePassword(Password password) async {
    final finder = Finder(filter: Filter.byKey(password.id));

    await store.update(_db!, password.toJson(), finder: finder);
  }

  Future deletePassword(Password password) async {
    final finder = Finder(filter: Filter.byKey(password.id));

    await store.delete(_db!, finder: finder);
  }

  Future deleteAllPassword() async {
    await store.delete(_db!);
  }
}
