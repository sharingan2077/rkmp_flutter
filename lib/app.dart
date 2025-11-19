import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/service_locator.dart';
import 'routes/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Крокодилий заповедник',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router,
    );
  }
}