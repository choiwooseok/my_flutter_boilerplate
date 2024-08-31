import '../entity/post.dart';
import '../repository/posts_repository.dart';

class FetchPostByIdUseCase {
  final PostsRepository _postsRepository;

  FetchPostByIdUseCase(this._postsRepository);

  Future<Post?> fetchPostById(int id) async {
    return await _postsRepository.fetchPostById(id);
  }
}
