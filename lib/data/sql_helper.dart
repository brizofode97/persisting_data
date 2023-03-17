import '../models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class SqlHelper {
  final String colId = 'id';
  final String colName = 'name';
  final String colDate = 'date';
  final String colNotes = 'notes';
  final String colPosition = 'position';
  final String tableNote = 'notes';

  static Database? _db;

  final int version = 1;

  static SqlHelper? singleton;

  SqlHelper._internal();

  factory SqlHelper() {
    singleton ??= SqlHelper._internal();
    return singleton as SqlHelper;
  }

  Future<Database> init() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final dbPath = join(dir.path, 'notes.db');
    final Database dbNote =
        await openDatabase(dbPath, version: version, onCreate: _createDb);
    return dbNote;
  }

  Future _createDb(Database db, int version) async {
    String query =
        'CREATE TABLE $tableNote ($colId INTEGER PRIMARY KEY, $colName TEXT, $colDate TEXT, $colNotes TEXT, $colPosition INTEGER)';
    await db.execute(query);
  }

  Future<List<Note>> getNotes() async {
    _db ??= await init();
    List<Map<String, dynamic>> notesList =
        await _db!.query(tableNote, orderBy: colPosition);
    return notesList.map((items) {
      return Note.fromMap(items);
    }).toList();
  }

  Future<int> insertNote(Note note) async {
    note.position = await findPosition();
    int result = await _db!.insert(tableNote, note.toMap());
    return result;
  }

  Future<int> updateNote(Note note) async {
    int result = await _db!.update(tableNote, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(Note note) async {
    int result =
        await _db!.delete(tableNote, where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> findPosition() async {
    String query = 'SELECT max($colPosition) FROM $tableNote';
    List<Map> queryResult = await _db!.rawQuery(query);
    int? position = queryResult.first.values.first;
    position = (position == null) ? 0 : position++;
    return position;
  }

  Future updaptePositions(bool increment, int start, int end) async {
    String sql;
    if (increment) {
      sql = 'UPDATE $tableNote SET $colPosition = $colPosition + 1 ';
      // 'WHERE $colPosition >= $start and $colPosition <= $end';
    } else {
      sql = 'UPDATE $tableNote SET $colPosition = $colPosition - 1 ';
      // 'WHERE $colPosition >= $start and $colPosition <= $end';
    }
    await _db!.rawUpdate(sql);
  }
}
