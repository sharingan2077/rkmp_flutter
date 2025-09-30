import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CrocodileScreen extends StatefulWidget {
  const CrocodileScreen({super.key});

  @override
  State<CrocodileScreen> createState() => _CrocodileScreenState();
}

class _CrocodileScreenState extends State<CrocodileScreen> {
  int _selectedIndexImage = 0;

  void _increaseIndexImage() {
    setState(() {
      _selectedIndexImage = (_selectedIndexImage + 1) % 3;
    });
  }

  static const List<String> _images = [
    'assets/images/crocodile_1.jpg',
    'assets/images/crocodile_2.webp',
    'assets/images/crocodile_3.webp',
  ];

  void _decreaseIndexImage() {
    setState(() {
      _selectedIndexImage = (_selectedIndexImage - 1 + 3) % 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Крокодилы", style: TextStyle(fontSize: 26, color: Colors.green, fontWeight: FontWeight.bold),),
          SizedBox(height: 50),

          Image.asset(_images[_selectedIndexImage], width: 300, height: 200),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _decreaseIndexImage,
                child: Icon(Icons.arrow_back),
              ),
              ElevatedButton(
                onPressed: _increaseIndexImage,
                child: Icon(Icons.arrow_forward),
              )
            ],
          ),
        ],
      ),
    );
  }
}
