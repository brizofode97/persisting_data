//Lien de recherche :
//https://drift.simonbinder.eu/docs/getting-started/
//https://drift.simonbinder.eu/docs/platforms/
//



import 'package:drift/drift.dart';


//import for open the database
import 'dart:io';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'moor_db.g.dart';

class BlogPosts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  TextColumn get content => text().nullable()();
  DateTimeColumn get date => dateTime().nullable()();
}

@DriftDatabase(tables: [BlogPosts])
class BlogDb extends _$BlogDb {
  BlogDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<BlogPost>> getPosts() => (select(blogPosts)
        ..orderBy([
          (post) => OrderingTerm(expression: post.date, mode: OrderingMode.desc)
        ]))
      .get();

  Future<int> insertPost(BlogPostsCompanion post) =>
      into(blogPosts).insert(post);

  Future<bool> updatePost(BlogPost post) => update(blogPosts).replace(post);

  Future<int> deletePost(BlogPost post) => delete(blogPosts).delete(post);
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

