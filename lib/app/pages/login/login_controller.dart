// lib/app/pages/login/login_controller.dart
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../data/datasources/auth_remote_data_source.dart';
import '../../../data/repositories/data_auth_repository.dart';
import 'login_presenter.dart';

class LoginController extends Controller {
  final LoginPresenter _presenter;

  String? errorMessage;
  bool isLoading = false;

  LoginController()
      : _presenter = LoginPresenter(
          DataAuthRepository(
            remoteDataSource: AuthRemoteDataSourceImpl(client: http.Client()),
            storage: FlutterSecureStorage(),
          ),
        ),
        super();

  @override
  void initListeners() {
    _presenter.loginOnComplete = () async {
      isLoading = false;
      refreshUI();

      try {
        final user = await _presenter.getCurrentUser();
        if (user.accesoSistema == true) {
          ScaffoldMessenger.of(getContext()).showSnackBar(
            const SnackBar(content: Text('Login exitoso')),
          );
          Navigator.of(getContext()).pushReplacementNamed('/dashboard');
        } else {
          errorMessage = 'No tiene permisos para acceder al sistema.';
          refreshUI();
          ScaffoldMessenger.of(getContext()).showSnackBar(
            SnackBar(
              content: Text(errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        errorMessage = e.toString();
        refreshUI();
        ScaffoldMessenger.of(getContext()).showSnackBar(
          SnackBar(
            content: Text(errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    };

    _presenter.loginOnError = (e) {
      isLoading = false;
      errorMessage = e.toString();
      refreshUI();
      ScaffoldMessenger.of(getContext()).showSnackBar(
        SnackBar(
          content: Text(errorMessage ?? 'Error desconocido'),
          backgroundColor: Colors.red,
        ),
      );
    };
  }

  void login(String email, String password) {
    isLoading = true;
    errorMessage = null;
    refreshUI();
    _presenter.login(email, password);
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }
}
