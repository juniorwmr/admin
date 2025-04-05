import 'package:admin/src/core/di/injection_container.dart';
import 'package:admin/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:admin/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:admin/src/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:admin/src/features/main/presentation/screens/main_screen.dart';
import 'package:admin/src/shared/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    final authController = injector<AuthController>();
    final isAuthenticated = authController.value.isAuthenticated;
    final isLoading = authController.value.isLoading;
    final isLoginRoute = state.matchedLocation == '/login';
    final isLoadingRoute = state.matchedLocation == '/loading';

    if (isLoading && !isLoadingRoute) {
      return '/loading';
    }

    if (!isLoading && isLoadingRoute) {
      return isAuthenticated ? '/' : '/login';
    }

    if (!isAuthenticated && !isLoginRoute) {
      return '/login';
    }

    if (isAuthenticated && isLoginRoute) {
      return '/';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/loading',
      builder: (context, state) => const LoadingScreen(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/users',
          builder: (context, state) => const Center(child: Text('Usuários')),
        ),
        GoRoute(
          path: '/settings',
          builder:
              (context, state) => const Center(child: Text('Configurações')),
        ),
      ],
    ),
  ],
  errorBuilder:
      (context, state) =>
          const Scaffold(body: Center(child: Text('Página não encontrada'))),
);
