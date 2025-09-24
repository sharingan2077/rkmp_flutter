import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home, color: Colors.purple, size: 30),
              SizedBox(width: 4),
              Text(
                "Домашняя страница!",
                style: TextStyle(fontSize: 30, color: Colors.purple),
              ),
            ],
          ),
          SizedBox(height: 12),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 300),
            child: Text(
              "Вы можете переключаться на экраны: дома, крокодилов, калькулятора, гифки, списка, используя нижнюю панель навигации!",
              style: TextStyle(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
