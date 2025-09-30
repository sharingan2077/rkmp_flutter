import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  double? _result = null;
  double? _x = null;
  double? _y = null;

  void add() {
    setState(() {
      _result = (_x != null && _y != null) ? _x! + _y! : null;
    });
  }

  void subtract() {
    setState(() {
      _result = (_x != null && _y != null) ? _x! - _y! : null;
    });
  }

  void multiply() {
    setState(() {
      _result = (_x != null && _y != null) ? _x! * _y! : null;
    });
  }

  void divide() {
    setState(() {
      _result = (_x != null && _y != null) ? _x! / _y! : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "Введите первое число",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 20), // небольшой отступ между текстом и полем
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 18),
                  onChanged: (numberStr) {
                    _x = double.tryParse(numberStr);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "...",
                    border: OutlineInputBorder(), // по желанию для рамки
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "Введите второе число",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 20), // небольшой отступ между текстом и полем
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 18),
                  onChanged: (numberStr) {
                    _y = double.tryParse(numberStr);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "...",
                    border: OutlineInputBorder(), // по желанию для рамки
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Выберите операцию",
          style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: add, child: Text("+")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: subtract, child: Text("-")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: multiply, child: Text("*")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: divide, child: Text("/")),
          ],
        ),
        SizedBox(height: 20),
        Text(
          "Результат",
          style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 20),
        Text(
          "${_result ?? "Not Defined"}",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
