// lib/di/injection_container.dart
import 'package:get_it/get_it.dart';

import '../presentation/bloc/empleado/empleado_bloc.dart';
import '../presentation/bloc/login/login_bloc.dart';
import '../repositories/data/auth/user_repository_impl.dart';
import '../repositories/data/empleado/empleado_repository_impl.dart';
import '../services/api/api_client.dart';
import '../usecases/empleado/empleado_usecase.dart';
import '../usecases/login/login_usecase.dart';

final GetIt injector = GetIt.instance;

void setupDependencies() {
  // Servicios
  injector.registerLazySingleton(() => ApiClient());

  // Repositorios
  injector
      .registerLazySingleton(() => UserRepositoryImpl(injector<ApiClient>()));

  injector.registerLazySingleton(
      () => EmpleadoRepositoryImpl(injector<ApiClient>()));
  // Casos de uso
  injector.registerLazySingleton(
      () => LoginUseCase(injector<UserRepositoryImpl>()));

  // BLoC
  injector.registerFactory(() => LoginBloc(injector<LoginUseCase>()));
  injector.registerFactory(() => EmpleadoBloc(injector<EmpleadoUseCase>()));
}
