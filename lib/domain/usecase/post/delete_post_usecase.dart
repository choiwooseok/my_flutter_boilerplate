import '../../entity/post_entity.dart';
import '../../repository/posts_repository.dart';

class DeletePostUseCase {
  final PostsRepository _postsRepository;

  DeletePostUseCase(this._postsRepository);

  Future<List<PostEntity>> deletePost(int id) async {
    return await _postsRepository.deletePost(id);
  }
}
