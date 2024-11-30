// lib/app/middleware/auth_middleware.dart

import 'package:flutter/material.dart';

import '../services/navigation_service.dart';
import '../services/session_manager.dart';

class AuthMiddleware extends NavigatorObserver {
  final SecureSessionManager sessionManager;
  final NavigationService navigationService;

  AuthMiddleware(this.sessionManager, this.navigationService);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _checkAuthentication(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) _checkAuthentication(newRoute);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  void _checkAuthentication(Route<dynamic> route) async {
    // Lista de rutas que requieren autenticación
    const protectedRoutes = [
      '/dashboard',
      '/profile',
      '/settings',
      // Agrega otras rutas protegidas
    ];

    // Lista de rutas públicas
    const publicRoutes = [
      '/login',
      '/register',
      '/forgot-password',
    ];

    final routeName = route.settings.name;
    if (routeName == null) return;

    final isAuthenticated = await sessionManager.isAuthenticated;

    if (protectedRoutes.contains(routeName) && !isAuthenticated) {
      // Redirigir al login si intenta acceder a una ruta protegida sin autenticación
      navigationService.pushReplacementNamed('/login');
    } else if (publicRoutes.contains(routeName) && isAuthenticated) {
      // Redirigir al dashboard si intenta acceder a rutas públicas estando autenticado
      navigationService.pushReplacementNamed('/dashboard');
    }
  }
}
