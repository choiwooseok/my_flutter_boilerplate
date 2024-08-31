import 'data/datasource/local/post_datasource.dart';
import 'data/repository/posts_repository_impl.dart';
import 'domain/usecase/add_post_usecase.dart';
import 'domain/usecase/delete_post_usecase.dart';
import 'domain/usecase/fetch_post_by_id_usecase.dart';
import 'domain/usecase/fetch_posts_usecase.dart';
import 'domain/usecase/update_post_usecase.dart';

class DIContainer {
  static final DIContainer _instance = DIContainer._internal();
  factory DIContainer() => _instance;
  DIContainer._internal();

  final _dependencies = <String, dynamic>{};

  void alloc() {
    // Data Layer
    _dependencies['PostsDataSource'] = PostsDataSource();
    _dependencies['PostsRepository'] =
        PostsRepositoryImpl(postsDataSource: _dependencies['PostsDataSource']);

    // Domain Layer
    _dependencies['AddPostUseCase'] =
        AddPostUseCase(_dependencies['PostsRepository']);
    _dependencies['DeletePostUseCase'] =
        DeletePostUseCase(_dependencies['PostsRepository']);
    _dependencies['FetchPostByIdUseCase'] =
        FetchPostByIdUseCase(_dependencies['PostsRepository']);
    _dependencies['FetchPostsUseCase'] =
        FetchPostsUseCase(_dependencies['PostsRepository']);
    _dependencies['UpdatePostUseCase'] =
        UpdatePostUseCase(_dependencies['PostsRepository']);

    // Presentation Layer
  }

  T get<T>(String key) {
    return _dependencies[key];
  }

  void dispose() {
    _dependencies.clear();
  }
}
