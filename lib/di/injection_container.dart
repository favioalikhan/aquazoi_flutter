// lib/di/injection_container.dart
import 'package:get_it/get_it.dart';

import '../presentation/bloc/login/login_bloc.dart';
import '../repositories/data/auth/user_repository_impl.dart';
import '../services/api/api_client.dart';
import '../usecases/login/login_usecase.dart';

final GetIt injector = GetIt.instance;

void setupDependencies() {
  // Servicios
  injector.registerLazySingleton(() => ApiClient());

  // Repositorios
  injector
      .registerLazySingleton(() => UserRepositoryImpl(injector<ApiClient>()));

  // Casos de uso
  injector.registerLazySingleton(
      () => LoginUseCase(injector<UserRepositoryImpl>()));

  // BLoC
  injector.registerFactory(() => LoginBloc(injector<LoginUseCase>()));
}
