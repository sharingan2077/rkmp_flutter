import 'package:flutter/material.dart';
import '../models/crocodile.dart';

class AddCrocodileScreen extends StatefulWidget {
  final Function(Crocodile) onCrocodileAdded;

  const AddCrocodileScreen({super.key, required this.onCrocodileAdded});

  @override
  State<AddCrocodileScreen> createState() => _AddCrocodileScreenState();
}

class _AddCrocodileScreenState extends State<AddCrocodileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _speciesController = TextEditingController();
  final _ageController = TextEditingController();
  final _lengthController = TextEditingController();
  final _weightController = TextEditingController();
  final _enclosureController = TextEditingController();

  String _healthStatus = 'Здоров';
  final List<String> _healthOptions = ['Здоров', 'Требует осмотра', 'На лечении'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final crocodile = Crocodile(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        species: _speciesController.text,
        age: int.parse(_ageController.text),
        length: double.parse(_lengthController.text),
        weight: double.parse(_weightController.text),
        healthStatus: _healthStatus,
        lastFed: DateTime.now(),
        enclosure: _enclosureController.text,
      );

      widget.onCrocodileAdded(crocodile);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Добавить крокодила')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Имя'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите имя';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _speciesController,
                decoration: const InputDecoration(labelText: 'Вид'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите вид';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Возраст (лет)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите возраст';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lengthController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Длина (м)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите длину';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Вес (кг)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите вес';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _enclosureController,
                decoration: const InputDecoration(labelText: 'Вольер'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите номер вольера';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _healthStatus,
                items: _healthOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _healthStatus = newValue!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Состояние здоровья'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Добавить крокодила'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}