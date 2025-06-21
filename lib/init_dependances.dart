import 'package:blog/core/common/cubits/user_login/user_login_cubit.dart';
import 'package:blog/features/auth/data/data_source/remote_data_sorce.dart';
import 'package:blog/features/auth/data/repository/auth_repository_imp.dart';
import 'package:blog/features/auth/domain/repository/repository.dart';
import 'package:blog/features/auth/domain/usecases/SignupUsecase.dart';
import 'package:blog/features/auth/domain/usecases/currunt_user.dart';
import 'package:blog/features/auth/ui/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/keys/SupabaseKey.dart';
import 'features/auth/domain/usecases/SigninUsecase.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton(() => UserLoginCubit());

  final supabase = await Supabase.initialize(
    url: SupabaseCredential.supabaseUrl,
    anonKey: SupabaseCredential.subabaseKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
  _authInit();


}

void _authInit() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceSupabaseImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<DomainAuthRepo>(
    () => AuthRepositoryImpl(dataSource: serviceLocator()),
  );

  serviceLocator.registerFactory(() => SignupUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => SigninUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      signupUsecase: serviceLocator(),
      signinUsecase: serviceLocator(),
      currentUser: serviceLocator(),
      userLoginCubit: serviceLocator(),
    ),
  );
}
