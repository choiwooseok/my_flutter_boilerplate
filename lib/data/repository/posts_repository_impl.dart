import '../../domain/entity/post_entity.dart';
import '../../domain/repository/posts_repository.dart';
import '../datasource/local/post_datasource.dart';
import '../datasource/remote/rest_apis.dart';
import '../mapping/post_mapping.dart';
import '../model/post_model.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsDataSource postsDataSource;

  final RestApis restApis = RestApis();

  PostsRepositoryImpl({required this.postsDataSource});

  @override
  Future<List<PostEntity>> fetchPosts() async {
    final List<PostModel> posts = await postsDataSource.getPosts();
    return posts.map((e) => PostMapping.toEntity(e)).toList();
  }

  @override
  Future<List<PostEntity>> addPost(PostEntity post) async {
    final postModel = PostMapping.toModel(post);
    final List<PostModel> posts = await postsDataSource.addPost(postModel);
    return posts.map((e) => PostMapping.toEntity(e)).toList();
  }

  @override
  Future<List<PostEntity>> deletePost(int id) async {
    final List<PostModel> posts = await postsDataSource.deletePost(id);
    return posts.map((e) => PostMapping.toEntity(e)).toList();
  }

  @override
  Future<PostEntity?> fetchPostById(int id) async {
    final postModel = await postsDataSource.getPost(id);
    if (postModel == null) {
      return null;
    }
    return PostMapping.toEntity(postModel);
  }

  @override
  Future<List<PostEntity>> updatePost(PostEntity post) async {
    final postModel = PostMapping.toModel(post);
    final List<PostModel> posts = await postsDataSource.updatePost(postModel);
    return posts.map((e) => PostMapping.toEntity(e)).toList();
  }
}
