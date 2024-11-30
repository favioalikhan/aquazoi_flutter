// lib/routes.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import '/app/pages/Home/home_view.dart';
import '../di/injection_container.dart';
import '../presentation/bloc/login/login_bloc.dart';
import '../presentation/pages/home/home_page.dart';
import '../presentation/pages/login/login_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => BlocProvider(
        create: (_) => injector<LoginBloc>(),
        child: const LoginPage(),
      ),
  //'/dashboard': (context) => HomeView(),
  '/dashboard': (context) => HomePage(),
};
