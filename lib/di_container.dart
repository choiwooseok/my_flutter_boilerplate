import 'data/datasource/local/post_datasource.dart';
import 'data/repository/posts_repository_impl.dart';
import 'domain/usecase/post/add_post_usecase.dart';
import 'domain/usecase/post/delete_post_usecase.dart';
import 'domain/usecase/post/fetch_post_by_id_usecase.dart';
import 'domain/usecase/post/fetch_posts_usecase.dart';
import 'domain/usecase/post/update_post_usecase.dart';
import 'domain/usecase/user/fetch_user_by_id_usecase.dart';
import 'domain/usecase/user/fetch_users_usecase.dart';

class DIContainer {
  static final DIContainer _instance = DIContainer._internal();
  factory DIContainer() => _instance;
  DIContainer._internal();

  final _dependencies = <Type, dynamic>{};

  void alloc() {
    // Data Layer
    register<PostsDataSource>(PostsDataSource());
    register<PostsRepositoryImpl>(
        PostsRepositoryImpl(postsDataSource: get<PostsDataSource>()));

    // Domain Layer
    register<AddPostUseCase>(AddPostUseCase(get<PostsRepositoryImpl>()));
    register<DeletePostUseCase>(DeletePostUseCase(get<PostsRepositoryImpl>()));
    register<FetchPostByIdUseCase>(
        FetchPostByIdUseCase(get<PostsRepositoryImpl>()));
    register<FetchPostsUseCase>(FetchPostsUseCase(get<PostsRepositoryImpl>()));
    register<UpdatePostUseCase>(UpdatePostUseCase(get<PostsRepositoryImpl>()));

    register<FetchUsersUseCase>(FetchUsersUseCase());
    register<FetchUserByIdUseCase>(FetchUserByIdUseCase());

    // Presentation Layer
  }

  T get<T>() => _dependencies[T] as T;

  void register<T>(T instance) => _dependencies[T] = instance;

  void dispose() {
    _dependencies.clear();
  }
}
