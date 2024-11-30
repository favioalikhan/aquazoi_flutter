// lib/domain/usecases/login_usecase.dart
import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../repositories/auth_repository.dart';

class LoginUseCase extends CompletableUseCase<LoginUseCaseParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Stream<void>> buildUseCaseStream(LoginUseCaseParams? params) async {
    final controller = StreamController<void>();
    try {
      await repository.authenticate(
        email: params!.email,
        password: params.password,
      );
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}

class LoginUseCaseParams {
  final String email;
  final String password;

  LoginUseCaseParams(this.email, this.password);
}
