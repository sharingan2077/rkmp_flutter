import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';

class CrocodileFormScreen extends StatefulWidget {
  const CrocodileFormScreen({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  final void Function(
    String name,
    String species,
    int age,
    double length,
    double weight,
    CrocodileStatus status,
    String enclosure,
  )
  onSave;
  final VoidCallback onCancel;

  @override
  State<CrocodileFormScreen> createState() => _CrocodileFormScreenState();
}

class _CrocodileFormScreenState extends State<CrocodileFormScreen> {
  final _nameController = TextEditingController();
  final _speciesController = TextEditingController();
  final _ageController = TextEditingController();
  final _lengthController = TextEditingController();
  final _weightController = TextEditingController();
  final _enclosureController = TextEditingController();

  CrocodileStatus _status = CrocodileStatus.healthy;
  final List<CrocodileStatus> _statuses = CrocodileStatus.values;

  void _submitForm() {
    final name = _nameController.text.trim();
    final species = _speciesController.text.trim();
    final enclosure = _enclosureController.text.trim();
    final ageText = _ageController.text;
    final lengthText = _lengthController.text;
    final weightText = _weightController.text;

    if (name.isEmpty ||
        species.isEmpty ||
        enclosure.isEmpty ||
        ageText.isEmpty ||
        lengthText.isEmpty ||
        weightText.isEmpty) {
      return;
    }

    final age = int.tryParse(ageText);
    final length = double.tryParse(lengthText);
    final weight = double.tryParse(weightText);

    if (age == null || length == null || weight == null) {
      return;
    }

    widget.onSave(name, species, age, length, weight, _status, enclosure);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Добавить крокодила')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Имя'),
            ),
            TextField(
              controller: _speciesController,
              decoration: const InputDecoration(labelText: 'Вид'),
            ),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Возраст (лет)'),
            ),
            TextField(
              controller: _lengthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Длина (м)'),
            ),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Вес (кг)'),
            ),
            TextField(
              controller: _enclosureController,
              decoration: const InputDecoration(labelText: 'Вольер'),
            ),
            DropdownButtonFormField<CrocodileStatus>(
              initialValue: _status,
              items: _statuses.map((status) {
                return DropdownMenuItem<CrocodileStatus>(
                  value: status,
                  child: Text(status.label),
                );
              }).toList(),
              onChanged: (newValue) {
                _status = newValue!;
              },
              decoration: const InputDecoration(
                labelText: 'Состояние здоровья',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Добавить крокодила'),
            ),
          ],
        ),
      ),
    );
  }
}
