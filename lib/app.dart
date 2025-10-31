import 'package:flutter/material.dart';
import 'package:project/features/dashboard/screens/dashboard_screen.dart';
import 'package:project/features/shared_state/crocodile_provider.dart';
import 'package:project/routes/app_router.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CrocodileProvider(),
      child: MaterialApp.router(
        title: 'Крокодилий заповедник',
        theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
        routerConfig: AppRouter.router,
      ),
    );
  }

}
