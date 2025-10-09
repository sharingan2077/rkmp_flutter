import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/screens/dashboard_screen.dart';
import 'package:project/features/crocodiles/state/crocodile_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Крокодилы',
      theme: ThemeData(primarySwatch: Colors.green),
      home: CrocodileContainer(),
    );
  }
}
