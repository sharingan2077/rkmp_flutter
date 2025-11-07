import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/features/crocodiles/screens/crocodile_form_screen.dart';
import 'package:project/features/crocodiles/screens/crocodiles_list_screen.dart';
import 'package:project/features/dashboard/screens/dashboard_screen.dart';
import 'package:project/features/food/screens/crocodile_food_screen.dart';
import 'package:project/features/habitats/screens/crocodile_habitat_screen.dart';
import 'package:project/features/login/screens/login_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => const MaterialPage(
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(
          child: DashboardScreen(),
        ),
      ),
      GoRoute(
        path: '/crocodiles',
        pageBuilder: (context, state) => const MaterialPage(
          child: CrocodilesListScreen(),
        ),
      ),
      GoRoute(
        path: '/crocodiles/form',
        pageBuilder: (context, state) => const MaterialPage(
          child: CrocodileFormScreen(),
        ),
      ),
      GoRoute(
        path: '/habitats',
        pageBuilder: (context, state) => const MaterialPage(
          child: CrocodileHabitatScreen(),
        ),
      ),
      GoRoute(
        path: '/food',
        pageBuilder: (context, state) => const MaterialPage(
          child: CrocodileFoodScreen(),
        ),
      ),
    ],
  );
}