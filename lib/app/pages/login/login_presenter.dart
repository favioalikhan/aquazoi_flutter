// lib/app/pages/login/login_presenter.dart
import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/get_current_user_usecase.dart';
import '../../../domain/usecases/login_usecase.dart';

class LoginPresenter extends Presenter {
  late Function loginOnComplete;
  late Function loginOnError;

  final LoginUseCase _loginUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  LoginPresenter(AuthRepository authRepository)
      : _loginUseCase = LoginUseCase(authRepository),
        _getCurrentUserUseCase = GetCurrentUserUseCase(authRepository);

  void login(String email, String password) {
    _loginUseCase.execute(
      _LoginObserver(this),
      LoginUseCaseParams(email, password),
    );
  }

  Future<User> getCurrentUser() {
    Completer<User> completer = Completer<User>();

    _getCurrentUserUseCase.execute(
      _GetUserCompleterObserver(completer),
    );

    return completer.future;
  }

  @override
  void dispose() {
    _loginUseCase.dispose();
    _getCurrentUserUseCase.dispose();
  }
}

class _GetUserCompleterObserver implements Observer<User?> {
  final Completer<User> completer;

  _GetUserCompleterObserver(this.completer);

  @override
  void onNext(User? user) {
    completer.complete(user);
  }

  @override
  void onError(e) {
    completer.completeError(e);
  }

  @override
  void onComplete() {
    // No necesitamos hacer nada aquí
  }
}

class _LoginObserver implements Observer<void> {
  final LoginPresenter presenter;

  _LoginObserver(this.presenter);

  @override
  void onComplete() {
    presenter.loginOnComplete();
  }

  @override
  void onError(e) {
    presenter.loginOnError(e);
  }

  @override
  void onNext(_) {}
}
