import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/features/shared_state/crocodile_provider.dart';
import 'package:provider/provider.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';
import 'package:project/features/crocodiles/models/crocodile_image_urls.dart';

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

    // Валидация пустых полей
    if (name.isEmpty ||
        species.isEmpty ||
        enclosure.isEmpty ||
        ageText.isEmpty ||
        lengthText.isEmpty ||
        weightText.isEmpty) {
      _showErrorDialog('Все поля должны быть заполнены');
      return;
    }

    // Валидация числовых значений
    final age = int.tryParse(ageText);
    final length = double.tryParse(lengthText);
    final weight = double.tryParse(weightText);

    if (age == null || length == null || weight == null) {
      _showErrorDialog('Возраст, длина и вес должны быть числами');
      return;
    }

    // Получаем провайдер и добавляем крокодила
    final provider = Provider.of<CrocodileProvider>(context, listen: false);
    provider.addCrocodile(
      name,
      species,
      age,
      length,
      weight,
      _status,
      enclosure,
    );

    // Возвращаемся назад
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
    // Очищаем контроллеры при уничтожении виджета
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 180,
              width: 300,
              margin: const EdgeInsets.only(bottom: 16),
              child: CachedNetworkImage(
                imageUrl: CrocodileImageUrls.getCrocodileFormImage(), // Используем статический метод
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(
                    Icons.image,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
              ),
            ),
            // Поля формы
            Expanded(
              child: ListView(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Имя'),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _speciesController,
                    decoration: const InputDecoration(labelText: 'Вид'),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Возраст (лет)'),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _lengthController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Длина (м)'),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Вес (кг)'),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _enclosureController,
                    decoration: const InputDecoration(labelText: 'Вольер'),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<CrocodileStatus>(
                    value: _status,
                    items: _statuses.map((status) {
                      return DropdownMenuItem<CrocodileStatus>(
                        value: status,
                        child: Text(status.label),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _status = newValue!;
                      });
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
          ],
        ),
      ),
    );
  }
}