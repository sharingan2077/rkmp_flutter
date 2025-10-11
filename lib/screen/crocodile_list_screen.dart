import 'package:flutter/material.dart';

class CrocodileListScreen extends StatefulWidget {
  const CrocodileListScreen({super.key});

  @override
  State<CrocodileListScreen> createState() => _CrocodileListScreenState();
}

class _CrocodileListScreenState extends State<CrocodileListScreen> {
  final List<Map<String, dynamic>> _crocodiles = [];
  final TextEditingController _speciesController = TextEditingController();
  final TextEditingController _countController = TextEditingController();

  void _addCrocodile() {
    final species = _speciesController.text.trim();
    final countText = _countController.text.trim();
    if (species.isEmpty || countText.isEmpty) return;

    final count = int.tryParse(countText);
    if (count == null) return;

    setState(() {
      _crocodiles.add({'species': species, 'count': count});
    });

    _speciesController.clear();
    _countController.clear();
  }

  void _removeFirstCrocodile() {
    if (_crocodiles.isEmpty) return;
    setState(() {
      _crocodiles.removeAt(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Крокодилы (Column + Scroll)')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(controller: _speciesController, decoration: const InputDecoration(labelText: 'Вид крокодила'),),
              TextField(controller: _countController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Количество'),),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [ElevatedButton(onPressed: _addCrocodile, child: const Text('Добавить'),),ElevatedButton(onPressed: _removeFirstCrocodile, child: const Text('Удалить первый'),),],),
              const SizedBox(height: 20),
              Column(
                children: _crocodiles
                    .map((c) => Card(
                  child: ListTile(
                    title: Text(c['species']),
                    subtitle: Text('Количество: ${c['count']}'),
                  ),
                ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}