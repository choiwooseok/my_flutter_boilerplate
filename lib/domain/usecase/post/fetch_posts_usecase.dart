import '../../entity/post_entity.dart';
import '../../repository/posts_repository.dart';

class FetchPostsUseCase {
  final PostsRepository _postsRepository;

  FetchPostsUseCase(this._postsRepository);

  Future<List<PostEntity>> fetchPosts() async {
    return await _postsRepository.fetchPosts();
  }
}
