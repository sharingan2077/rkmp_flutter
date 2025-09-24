import 'package:flutter/material.dart';
import 'package:project/calculator_screen.dart';
import 'package:project/crocodile_screen.dart';
import 'package:project/gif_screen.dart';
import 'package:project/home_screen.dart';
import 'package:project/list_screen.dart';

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
      home: const MyHomePage(title: 'Flutter Home Page'),
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
  int _selectedIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    CrocodileScreen(),
    CalculatorScreen(),
    const GifScreen(),
    const ListScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber, title: Text(widget.title)),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Начало"),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: "Крокодилы"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: "Калькулятор",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.gif), label: "Gif"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Список"),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
