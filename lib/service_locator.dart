import 'package:get_it/get_it.dart';
import 'package:project/features/crocodiles/cubit/crocodile_cubit.dart';
import 'package:project/features/food/cubit/food_cubit.dart';
import 'package:project/features/habitats/cubit/habitat_cubit.dart';
import 'package:project/features/auth/cubit/auth_cubit.dart';
import 'package:project/features/dashboard/cubit/dashboard_cubit.dart';

import 'features/medical/cubit/medical_cubit.dart';
import 'features/visitors/cubit/visitor_cubit.dart';

final GetIt locator = GetIt.instance;

// service_locator.dart
void setupLocator() {
  locator.registerLazySingleton<AuthCubit>(() => AuthCubit());
  locator.registerLazySingleton<DashboardCubit>(() => DashboardCubit());
  locator.registerLazySingleton<CrocodileCubit>(() => CrocodileCubit());
  locator.registerLazySingleton<FoodCubit>(() => FoodCubit());
  locator.registerLazySingleton<HabitatCubit>(() => HabitatCubit());

  // Новые Cubit
  locator.registerLazySingleton<MedicalCubit>(() => MedicalCubit());
  locator.registerLazySingleton<VisitorCubit>(() => VisitorCubit());
}