import '../entity/post.dart';

abstract class PostsRepository {
  Future<int> addPost(Post post);
  Future<List<Post>> fetchPosts();
  Future<Post?> fetchPostById(int id);
  Future<int> updatePost(Post post);
  Future<int> deletePost(int id);
}
