import '../entity/post.dart';
import '../repository/posts_repository.dart';

class FetchPostsUseCase {
  final PostsRepository _postsRepository;

  FetchPostsUseCase(this._postsRepository);

  Future<List<Post>> fetchPosts() async {
    return await _postsRepository.fetchPosts();
  }
}
