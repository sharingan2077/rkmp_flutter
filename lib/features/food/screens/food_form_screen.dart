// features/food/screens/food_form_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project/service_locator.dart';
import '../cubit/food_cubit.dart';

class FoodFormScreen extends StatefulWidget {
  const FoodFormScreen({super.key});

  @override
  State<FoodFormScreen> createState() => _FoodFormScreenState();
}

class _FoodFormScreenState extends State<FoodFormScreen> {
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitController = TextEditingController();

  void _submitForm() {
    final name = _nameController.text.trim();
    final type = _typeController.text.trim();
    final unit = _unitController.text.trim();
    final quantityText = _quantityController.text;

    if (name.isEmpty || type.isEmpty || unit.isEmpty || quantityText.isEmpty) {
      _showErrorDialog('Все поля должны быть заполнены');
      return;
    }

    final quantity = double.tryParse(quantityText);
    if (quantity == null) {
      _showErrorDialog('Количество должно быть числом');
      return;
    }

    final cubit = locator<FoodCubit>();
    cubit.addFood(name, type, quantity, unit);

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
    _typeController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить еду'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Название еды'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _typeController,
              decoration: const InputDecoration(labelText: 'Тип (рыба, мясо и т.д.)'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Количество'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _unitController,
              decoration: const InputDecoration(labelText: 'Единица измерения (кг, шт.)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Добавить еду'),
            ),
          ],
        ),
      ),
    );
  }
}