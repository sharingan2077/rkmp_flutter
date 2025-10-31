import 'package:flutter/material.dart';
import 'package:project/features/dashboard/screens/dashboard_screen.dart';
import 'package:project/features/shared_state/crocodile_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Крокодилий заповедник',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const CrocodileContainer(),
    );
  }
}