import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../views/screens/signup_screen.dart';
import '../../views/screens/login_screen.dart';
import '../../views/screens/dashboard_screen.dart';

GoRouter createAppRouter(AuthProvider authProvider) {
  return GoRouter(
    initialLocation: '/signup',
    refreshListenable: authProvider,
    redirect: (context, state) {
      final isAuth = authProvider.isAuthenticated;
      final goingToAuth = state.matchedLocation == '/login' || state.matchedLocation == '/signup';

      if (!isAuth && state.matchedLocation == '/dashboard') {
        return '/login';
      }
      if (isAuth && goingToAuth) {
        return '/dashboard';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
  );
}
