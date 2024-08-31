import 'package:flutter/material.dart';

import '../../di_container.dart';
import '../../domain/entity/post.dart';
import '../../domain/usecase/add_post_usecase.dart';
import '../../domain/usecase/delete_post_usecase.dart';
import '../../domain/usecase/fetch_posts_usecase.dart';

class PostsPageVM with ChangeNotifier {
  List<Post> _posts = [];
  List<Post> get posts => _posts;

  Future<void> fetchPosts() async {
    _posts = await DIContainer()
        .get<FetchPostsUseCase>("FetchPostsUseCase")
        .fetchPosts();
    notifyListeners();
  }

  Future<void> add(String title, String body) async {
    var post = Post(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      body: body,
    );

    await DIContainer().get<AddPostUseCase>("AddPostUseCase").addPost(post);
    await fetchPosts();
  }

  Future<void> delete(int id) async {
    await DIContainer()
        .get<DeletePostUseCase>("DeletePostUseCase")
        .deletePost(id);
    await fetchPosts();
  }
}
