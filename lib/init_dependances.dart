import 'package:blog/core/common/cubits/user_login/user_login_cubit.dart';
import 'package:blog/features/auth/data/data_source/remote_data_sorce.dart';
import 'package:blog/features/auth/data/repository/auth_repository_imp.dart';
import 'package:blog/features/auth/domain/repository/repository.dart';
import 'package:blog/features/auth/domain/usecases/SignupUsecase.dart';
import 'package:blog/features/auth/domain/usecases/currunt_user.dart';
import 'package:blog/features/auth/ui/bloc/auth_bloc.dart';
import 'package:blog/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:blog/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:blog/features/blog/data/models/blogModel.dart';
import 'package:blog/features/blog/data/repository/blog_repository_impl.dart';
import 'package:blog/features/blog/domain/repository/blog_repository.dart';
import 'package:blog/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog/features/blog/ui/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/keys/SupabaseKey.dart';
import 'features/auth/domain/usecases/SigninUsecase.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initHive(); // Initialize Hive first
  await _initSupabase(); // Initialize Supabase
  serviceLocator.registerLazySingleton(() => UserLoginCubit()); // Register UserLoginCubit
  _authInit();
  _blogInit();
}

Future<void> _initHive() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(BlogModeAdapter());
  final blogBox = await Hive.openBox<BlogMode>('blogs');
  serviceLocator.registerLazySingleton<Box<BlogMode>>(() => blogBox);
}

Future<void> _initSupabase() async {
  final supabase = await Supabase.initialize(
    url: SupabaseCredential.supabaseUrl,
    anonKey: SupabaseCredential.subabaseKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _authInit() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceSupabaseImpl(supabaseClient: serviceLocator()),
    )
    ..registerFactory<DomainAuthRepo>(
      () => AuthRepositoryImpl(dataSource: serviceLocator()),
    )
    ..registerFactory(() => SignupUsecase(serviceLocator()))
    ..registerFactory(() => SigninUsecase(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
        signupUsecase: serviceLocator(),
        signinUsecase: serviceLocator(),
        currentUser: serviceLocator(),
        userLoginCubit: serviceLocator(),
      ),
    );
}

void _blogInit() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(() => UploadBlog(serviceLocator()))
    ..registerFactory(() => GetAllBlogs(serviceLocator()))
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}