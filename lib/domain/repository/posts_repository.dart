import '../entity/post_entity.dart';

abstract class PostsRepository {
  Future<List<PostEntity>> addPost(PostEntity post);
  Future<List<PostEntity>> fetchPosts();
  Future<PostEntity?> fetchPostById(int id);
  Future<List<PostEntity>> updatePost(PostEntity post);
  Future<List<PostEntity>> deletePost(int id);
}
