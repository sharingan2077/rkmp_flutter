import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Крокодилы',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(body: Text("Привет"),),
    );
  }
}
