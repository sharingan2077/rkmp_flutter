import 'package:flutter/material.dart';

class CrocodileSeparated {
  final String species;
  final double length;

  CrocodileSeparated({required this.species, required this.length});
}

class CrocodileListSeparatedScreen extends StatefulWidget {
  const CrocodileListSeparatedScreen({super.key});

  @override
  State<CrocodileListSeparatedScreen> createState() =>
      _CrocodileListSeparatedScreenState();
}

class _CrocodileListSeparatedScreenState
    extends State<CrocodileListSeparatedScreen> {
  final List<CrocodileSeparated> _crocodiles = [];

  final TextEditingController _speciesController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();

  void _addCrocodile() {
    final species = _speciesController.text.trim();
    final lengthText = _lengthController.text.trim();

    if (species.isEmpty || lengthText.isEmpty) return;

    final length = double.tryParse(lengthText);
    if (length == null) return;

    setState(() {
      _crocodiles.add(CrocodileSeparated(species: species, length: length));
    });

    _speciesController.clear();
    _lengthController.clear();
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
      appBar: AppBar(title: const Text('Крокодилы (ListView.separated)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _speciesController,
              decoration: const InputDecoration(
                labelText: 'Вид крокодила',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _lengthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Длина (в метрах)',
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
              child: ListView.separated(
                itemCount: _crocodiles.length,
                itemBuilder: (context, index) {
                  final croc = _crocodiles[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Вид: ${croc.species}'),
                        Text('Длина: ${croc.length} м'),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
