import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/screens/dashboard_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Крокодилы',
      theme: ThemeData(primarySwatch: Colors.green),
      home: DashboardScreen(
        countAllCrocodiles: "1",
        countHealthyCrocodiles: "2",
        countNeedCheckupCrocodiles: "3",
        countTreatmentCrocodiles: "4",
      ),
    );
  }
}
