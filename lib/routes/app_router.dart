import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/features/crocodiles/screens/crocodile_form_screen.dart';
import 'package:project/features/crocodiles/screens/crocodiles_list_screen.dart';
import 'package:project/features/dashboard/screens/dashboard_screen.dart';
import 'package:project/features/food/screens/crocodile_food_screen.dart';
import 'package:project/features/habitats/screens/crocodile_habitat_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithBottomNav(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(),
            ),
          ),
          GoRoute(
            path: '/crocodiles',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CrocodilesListScreen(),
            ),
          ),
          GoRoute(
            path: '/habitats',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CrocodileHabitatScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/crocodiles/form',
        pageBuilder: (context, state) => const MaterialPage(
          child: CrocodileFormScreen(),
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
// Обертка для BottomNavigationBar
class ScaffoldWithBottomNav extends StatefulWidget {
  final Widget child;

  const ScaffoldWithBottomNav({super.key, required this.child});

  @override
  State<ScaffoldWithBottomNav> createState() => _ScaffoldWithBottomNavState();
}

class _ScaffoldWithBottomNavState extends State<ScaffoldWithBottomNav> {
  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    if (location.startsWith('/crocodiles')) return 1;
    if (location.startsWith('/habitats')) return 2;
    if (location == '/') return 0;

    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/crocodiles');
        break;
      case 2:
        context.go('/habitats');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getCurrentIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Крокодилы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.nature),
            label: 'Среда',
          ),
        ],
      ),
    );
  }
}