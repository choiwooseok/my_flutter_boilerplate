import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../util/constant.dart';
import '../../model/post_model.dart';

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

  Future<List<PostModel>> getPosts() async {
    final db = await database;
    var res = await db.query(kTableName);
    if (res.isEmpty) {
      return [];
    }
    return res.map((e) => PostModel.fromMap(e)).toList();
  }

  Future<List<PostModel>> addPost(PostModel post) async {
    final db = await database;
    await db.insert(kTableName, post.toMap());
    return getPosts();
  }

  Future<List<PostModel>> deletePost(int id) async {
    final db = await database;
    await db.delete(kTableName, where: 'id = ?', whereArgs: [id]);
    return getPosts();
  }

  Future<PostModel?> getPost(int id) async {
    final db = await database;
    var res = await db.query(kTableName, where: 'id = ?', whereArgs: [id]);

    if (res.isEmpty) {
      return null;
    }

    return PostModel.fromMap(res.first);
  }

  Future<List<PostModel>> updatePost(PostModel post) async {
    final db = await database;
    await db.update(kTableName, post.toMap(),
        where: 'id = ?', whereArgs: [post.id]);
    return getPosts();
  }
}
