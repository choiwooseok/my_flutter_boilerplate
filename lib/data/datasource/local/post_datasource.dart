import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entity/post.dart';
import '../../../util/constant.dart';

class PostsDataSource {
  static final PostsDataSource instance = PostsDataSource._internal();
  factory PostsDataSource() => instance;
  PostsDataSource._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    _database = await openDatabase(join(documentsDirectory.path, kDatabaseName),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE $kTableName (
            id INTEGER PRIMARY KEY,
            title TEXT,
            body TEXT
          )
          ''');
    });

    return _database!;
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  Future<List<Post>> getPosts() async {
    final db = await database;
    var res = await db.query(kTableName);
    if (res.isEmpty) {
      return [];
    }
    return res.map((e) => Post.fromJson(e)).toList();
  }

  Future<int> addPost(Post post) async {
    final db = await database;
    return db.insert(kTableName, post.toMap());
  }

  Future<int> deletePost(int id) async {
    final db = await database;
    return db.delete(kTableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<Post?> getPost(int id) async {
    final db = await database;
    var res = await db.query(kTableName, where: 'id = ?', whereArgs: [id]);

    if (res.isEmpty) {
      return null;
    }

    return Post.fromJson(res.first);
  }

  Future<int> updatePost(Post post) async {
    final db = await database;
    return db.update(kTableName, post.toMap(),
        where: 'id = ?', whereArgs: [post.id]);
  }
}
