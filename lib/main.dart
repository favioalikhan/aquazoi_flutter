// lib/main.dart
import 'package:flutter/material.dart';

import 'di/injection_container.dart' as di;
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.setupDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supervisor Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: appRoutes,
    );
  }
}

/*import 'package:aquazoi/presentation/pages/auth/login_screen.dart';
import 'package:aquazoi/presentation/pages/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supervisor Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      //home: ZoiAquaDashboard(),
      //home: LoginScreen(),
      routes: {
        '/': (context) => LoginScreen(),
        '/dashboard': (context) => ZoiAquaDashboard(),
      },
    );
  }
}*/
