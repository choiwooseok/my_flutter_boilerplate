import 'package:flutter/material.dart';

import '../../di_container.dart';
import '../../domain/entity/post_entity.dart';
import '../../domain/usecase/add_post_usecase.dart';
import '../../domain/usecase/delete_post_usecase.dart';
import '../../domain/usecase/fetch_posts_usecase.dart';

class PostsPageVM with ChangeNotifier {
  List<PostEntity> _posts = [];
  List<PostEntity> get posts => _posts;

  Future<void> fetchPosts() async {
    _posts = await DIContainer()
        .get<FetchPostsUseCase>("FetchPostsUseCase")
        .fetchPosts();
    notifyListeners();
  }

  Future<void> add(String title, String body) async {
    _posts = await DIContainer()
        .get<AddPostUseCase>("AddPostUseCase")
        .addPost(PostEntity(
          id: DateTime.now().millisecondsSinceEpoch,
          title: title,
          body: body,
        ));
    notifyListeners();
  }

  Future<void> delete(int id) async {
    _posts = await DIContainer()
        .get<DeletePostUseCase>("DeletePostUseCase")
        .deletePost(id);
    notifyListeners();
  }
}
