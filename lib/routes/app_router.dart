import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/food/screens/food_form_screen.dart';
import '../features/habitats/cubit/habitat_cubit.dart';
import '../features/habitats/screens/habitat_detail_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/dashboard/screens/dashboard_screen.dart';
import '../features/crocodiles/screens/crocodiles_list_screen.dart';
import '../features/crocodiles/screens/crocodile_form_screen.dart';
import '../features/food/screens/crocodile_food_screen.dart';
import '../features/habitats/screens/crocodile_habitat_screen.dart';
import '../features/medical/screens/add_medical_record_screen.dart';
import '../features/medical/screens/medical_detail_screen.dart';
import '../features/medical/screens/medical_list_screen.dart';
import '../features/visitors/screens/add_visitor_screen.dart';
import '../features/visitors/screens/visitors_list_screen.dart';
import '../service_locator.dart';

// routes/app_router.dart
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      // 1. Бизнес-экран авторизации
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // 2. Бизнес-экран дашборда
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardScreen(),
      ),

      // 3. Бизнес-экран крокодилов
      GoRoute(
        path: '/crocodiles',
        builder: (context, state) => const CrocodilesListScreen(),
      ),
      GoRoute(
        path: '/crocodiles/form',
        builder: (context, state) => const CrocodileFormScreen(),
      ),

      // 4. Бизнес-экран еды
      GoRoute(
        path: '/food',
        builder: (context, state) => const CrocodileFoodScreen(),
      ),
      GoRoute(
        path: '/food/form',
        builder: (context, state) => const FoodFormScreen(),
      ),

      // 5. Бизнес-экран среды обитания
      GoRoute(
        path: '/habitats',
        builder: (context, state) => const CrocodileHabitatScreen(),
      ),
      GoRoute(
        path: '/habitats/:id',
        builder: (context, state) {
          final habitatId = state.pathParameters['id']!;
          final habitatCubit = locator<HabitatCubit>();
          final habitat = habitatCubit.getHabitatById(habitatId);

          if (habitat == null) {
            return const Scaffold(
              body: Center(child: Text('Вольер не найден')),
            );
          }

          return HabitatDetailScreen(habitat: habitat);
        },
      ),

      // 6. Бизнес-экран медицинских записей
      GoRoute(
        path: '/medical',
        builder: (context, state) => const MedicalListScreen(),
      ),
      GoRoute(
        path: '/medical/add',
        builder: (context, state) => const AddMedicalRecordScreen(),
      ),
      GoRoute(
        path: '/medical/:id',
        builder: (context, state) {
          final recordId = state.pathParameters['id']!;
          return MedicalDetailScreen(recordId: recordId);
        },
      ),

      // 7. Бизнес-экран посетителей
      GoRoute(
        path: '/visitors',
        builder: (context, state) => const VisitorsListScreen(),
      ),
      GoRoute(
        path: '/visitors/add',
        builder: (context, state) => const AddVisitorScreen(),
      ),
    ],
  );
}