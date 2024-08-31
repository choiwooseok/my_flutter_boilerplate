import '../../entity/post_entity.dart';
import '../../repository/posts_repository.dart';

class UpdatePostUseCase {
  final PostsRepository _postsRepository;

  UpdatePostUseCase(this._postsRepository);

  Future<List<PostEntity>> updatePost(PostEntity post) async {
    return await _postsRepository.updatePost(post);
  }
}
