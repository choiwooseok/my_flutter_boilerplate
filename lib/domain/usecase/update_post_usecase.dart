import '../entity/post.dart';
import '../repository/posts_repository.dart';

class UpdatePostUseCase {
  final PostsRepository _postsRepository;

  UpdatePostUseCase(this._postsRepository);

  Future<int> updatePost(Post post) async {
    return await _postsRepository.updatePost(post);
  }
}
