import '../entity/post.dart';
import '../repository/posts_repository.dart';

class AddPostUseCase {
  final PostsRepository _postsRepository;

  AddPostUseCase(this._postsRepository);

  Future<int> addPost(Post post) async {
    return await _postsRepository.addPost(post);
  }
}
