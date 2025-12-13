// features/crocodiles/screens/crocodile_form_screen.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project/service_locator.dart';
import '../models/crocodile_status.dart';
import '../cubit/crocodile_cubit.dart';

class CrocodileFormScreen extends StatefulWidget {
  const CrocodileFormScreen({super.key});

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
      _showErrorDialog('Все поля должны быть заполнены');
      return;
    }

    final age = int.tryParse(ageText);
    final length = double.tryParse(lengthText);
    final weight = double.tryParse(weightText);

    if (age == null || length == null || weight == null) {
      _showErrorDialog('Возраст, длина и вес должны быть числами');
      return;
    }

    final cubit = locator<CrocodileCubit>();
    cubit.addCrocodile(
      name,
      species,
      age,
      length,
      weight,
      _status,
      enclosure,
    );

    context.pop();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ошибка'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _speciesController.dispose();
    _ageController.dispose();
    _lengthController.dispose();
    _weightController.dispose();
    _enclosureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить крокодила'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Заголовок вместо изображения
            Container(
              margin: const EdgeInsets.only(bottom: 20, top: 10),
              child: Column(
                children: [
                  const Icon(
                    Icons.psychology,
                    size: 50,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Новый обитатель заповедника',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.green[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Заполните информацию о крокодиле',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Форма
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Имя',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _speciesController,
              decoration: const InputDecoration(
                labelText: 'Вид',
                prefixIcon: Icon(Icons.pets),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Возраст (лет)',
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _lengthController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Длина (м)',
                      prefixIcon: Icon(Icons.straighten),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Вес (кг)',
                      prefixIcon: Icon(Icons.monitor_weight),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _enclosureController,
              decoration: const InputDecoration(
                labelText: 'Вольер',
                prefixIcon: Icon(Icons.home),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<CrocodileStatus>(
              value: _status,
              items: _statuses.map((status) {
                return DropdownMenuItem<CrocodileStatus>(
                  value: status,
                  child: Row(
                    children: [
                      Icon(
                        _getStatusIcon(status),
                        color: _getStatusColor(status),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(status.label),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _status = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Состояние здоровья',
                prefixIcon: Icon(Icons.health_and_safety),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Добавить крокодила',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getStatusIcon(CrocodileStatus status) {
    switch (status) {
      case CrocodileStatus.healthy:
        return Icons.check_circle;
      case CrocodileStatus.needCheckup:
        return Icons.warning;
      case CrocodileStatus.treatment:
        return Icons.local_hospital;
    }
  }

  Color _getStatusColor(CrocodileStatus status) {
    switch (status) {
      case CrocodileStatus.healthy:
        return Colors.green;
      case CrocodileStatus.needCheckup:
        return Colors.orange;
      case CrocodileStatus.treatment:
        return Colors.red;
    }
  }
}