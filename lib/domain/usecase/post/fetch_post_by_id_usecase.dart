import '../../entity/post_entity.dart';
import '../../repository/posts_repository.dart';

class FetchPostByIdUseCase {
  final PostsRepository _postsRepository;

  FetchPostByIdUseCase(this._postsRepository);

  Future<PostEntity?> fetchPostById(int id) async {
    return await _postsRepository.fetchPostById(id);
  }
}
