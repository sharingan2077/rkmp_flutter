import 'package:flutter/material.dart';

class Crocodile {
  final int age;
  final String color;

  Crocodile({required this.age, required this.color});
}

class CrocodileListViewScreen extends StatefulWidget {
  const CrocodileListViewScreen({super.key});

  @override
  State<CrocodileListViewScreen> createState() => _CrocodileListViewScreenState();
}

class _CrocodileListViewScreenState extends State<CrocodileListViewScreen> {
  final List<Crocodile> _crocodiles = [];
  final TextEditingController _ageController = TextEditingController();

  final List<String> _colorOptions = [
    'Зелёный',
    'Коричневый',
    'Бирюзовый',
    'Светло-зелёный',
    'Лаймовый',
  ];

  int _currentColorIndex = 0;

  void _changeColor() {
    setState(() {
      _currentColorIndex = (_currentColorIndex + 1) % _colorOptions.length;
    });
  }

  void _addCrocodile() {
    final ageText = _ageController.text.trim();
    if (ageText.isEmpty) return;

    final age = int.tryParse(ageText);
    if (age == null) return;

    final color = _colorOptions[_currentColorIndex];
    setState(() {
      _crocodiles.add(Crocodile(age: age, color: color));
    });

    _ageController.clear();
  }

  void _removeFirstCrocodile() {
    if (_crocodiles.isEmpty) return;
    setState(() {
      _crocodiles.removeAt(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentColor = _colorOptions[_currentColorIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Крокодилы (ListView.builder)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Цвет крокодила: $currentColor',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _changeColor,
                  child: const Text('Сменить цвет'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Возраст крокодила',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _addCrocodile,
                  child: const Text('Добавить'),
                ),
                ElevatedButton(
                  onPressed: _removeFirstCrocodile,
                  child: const Text('Удалить первого'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: _crocodiles.length,
                itemBuilder: (context, index) {
                  final croc = _crocodiles[index];
                  return Card(
                    child: ListTile(
                      title: Text('Возраст: ${croc.age} лет'),
                      subtitle: Text('Цвет: ${croc.color}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
