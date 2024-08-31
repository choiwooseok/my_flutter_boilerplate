import 'package:my_boilerplate/data/datasource/remote/rest_apis.dart';

import '../../domain/entity/post.dart';
import '../../domain/repository/posts_repository.dart';
import '../datasource/local/post_datasource.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsDataSource postsDataSource;

  final RestApis restApis = RestApis();

  PostsRepositoryImpl({required this.postsDataSource});

  @override
  Future<List<Post>> fetchPosts() async {
    // remote Api call
    // await restApis.getPosts();

    // then insert to local database

    // then return from local database

    return await postsDataSource.getPosts();
  }

  @override
  Future<int> addPost(Post post) async {
    return await postsDataSource.addPost(post);
  }

  @override
  Future<int> deletePost(int id) async {
    return await postsDataSource.deletePost(id);
  }

  @override
  Future<Post?> fetchPostById(int id) async {
    return await postsDataSource.getPost(id);
  }

  @override
  Future<int> updatePost(Post post) async {
    return await postsDataSource.updatePost(post);
  }
}
