import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: 'Flutter Prac 4'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Text("Вишневский", style: TextStyle(color: Colors.green, fontSize: 30),),
          Text("Максим", style: TextStyle(color: Colors.green, fontSize: 30),),
          Text("Андреевич", style: TextStyle(color: Colors.green, fontSize: 30),),
          Text("ИКБО-06-22", style: TextStyle(color: Colors.green, fontSize: 30),),
              Text("Вишневский", style: TextStyle(color: Colors.green, fontSize: 30),),
              Text("Максим", style: TextStyle(color: Colors.green, fontSize: 30),),
              Text("Андреевич", style: TextStyle(color: Colors.green, fontSize: 30),),
              Text("ИКБО-06-22", style: TextStyle(color: Colors.green, fontSize: 30),),
              Text("Вишневский", style: TextStyle(color: Colors.green, fontSize: 30),),
              Text("Максим", style: TextStyle(color: Colors.green, fontSize: 30),),
              Text("Андреевич", style: TextStyle(color: Colors.green, fontSize: 30),),
              Text("ИКБО-06-22", style: TextStyle(color: Colors.green, fontSize: 30),),
              Text("Вишневский", style: TextStyle(color: Colors.green, fontSize: 30),),
              Text("Максим", style: TextStyle(color: Colors.green, fontSize: 30),),
              Text("Андреевич", style: TextStyle(color: Colors.green, fontSize: 30),),
              Text("ИКБО-06-22", style: TextStyle(color: Colors.green, fontSize: 30),),
              Text("Вишневский", style: TextStyle(color: Colors.green, fontSize: 30),),
              Text("Максим", style: TextStyle(color: Colors.green, fontSize: 30),),
              Text("Андреевич", style: TextStyle(color: Colors.green, fontSize: 30),),
              Text("ИКБО-06-22", style: TextStyle(color: Colors.green, fontSize: 30),),

        ]),
      ),
    );
  }
}
