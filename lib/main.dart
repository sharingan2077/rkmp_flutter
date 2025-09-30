import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
        appBar: AppBar(

          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,

          title: Text(widget.title),
        ),
        body: Center(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Вишневский Максим Андреевич   ', style: TextStyle(color: Colors.green),),
                const Text('ИКБО-06-22    ', style: TextStyle(color: Colors.green),),
                const Text('22И1111    ', style: TextStyle(color: Colors.green),),
                ElevatedButton(onPressed: null, child: const Text("Кнопочка"),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.greenAccent)
                ),)
              ],
            )
        )
    );
  }
}