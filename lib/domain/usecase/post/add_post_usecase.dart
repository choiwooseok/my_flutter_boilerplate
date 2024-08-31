import '../../entity/post_entity.dart';
import '../../repository/posts_repository.dart';

class AddPostUseCase {
  final PostsRepository _postsRepository;

  AddPostUseCase(this._postsRepository);

  Future<List<PostEntity>> addPost(PostEntity post) async {
    return await _postsRepository.addPost(post);
  }
}
