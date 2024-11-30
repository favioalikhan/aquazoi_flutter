import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../widgets/login/login_form.dart';
import 'login_controller.dart';

class LoginPage extends CleanView {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends CleanViewState<LoginPage, LoginController> {
  LoginPageState() : super(LoginController());

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255)
              ],
            ),
          ),
          child: ControlledWidgetBuilder<LoginController>(
            builder: (context, controller) {
              return SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: LoginForm(
                      isLoading: controller.isLoading,
                      onSubmit: (email, password) {
                        controller.login(email, password);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
}
