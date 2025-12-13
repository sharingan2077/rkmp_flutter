// features/crocodiles/screens/crocodile_form_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../service_locator.dart';
import '../../habitats/models/crocodile_habitat.dart';
import '../models/crocodile_status.dart';
import '../../habitats/cubit/habitat_cubit.dart';
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

  CrocodileStatus _status = CrocodileStatus.healthy;
  final List<CrocodileStatus> _statuses = CrocodileStatus.values;

  // Для выбора вольера
  String? _selectedHabitatId;
  List<CrocodileHabitat> _availableHabitats = [];

  @override
  void initState() {
    super.initState();
    // Загружаем доступные вольеры
    _loadAvailableHabitats();
  }

  void _loadAvailableHabitats() {
    final habitatCubit = locator<HabitatCubit>();
    _availableHabitats = habitatCubit.state.habitats;

    if (_availableHabitats.isNotEmpty) {
      _selectedHabitatId = _availableHabitats.first.id;
    }
  }

  void _submitForm() {
    final name = _nameController.text.trim();
    final species = _speciesController.text.trim();
    final ageText = _ageController.text;
    final lengthText = _lengthController.text;
    final weightText = _weightController.text;

    if (name.isEmpty ||
        species.isEmpty ||
        ageText.isEmpty ||
        lengthText.isEmpty ||
        weightText.isEmpty ||
        _selectedHabitatId == null) {
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

    // Находим выбранный вольер
    final selectedHabitat = _availableHabitats
        .firstWhere((habitat) => habitat.id == _selectedHabitatId);

    final crocodileCubit = locator<CrocodileCubit>();
    final habitatCubit = locator<HabitatCubit>();

    // Генерируем ID для нового крокодила
    final newCrocodileId = DateTime.now().microsecondsSinceEpoch.toString();

    // Добавляем крокодила с habitatId
    crocodileCubit.addCrocodile(
      name,
      species,
      age,
      length,
      weight,
      _status,
      selectedHabitat.name,
      selectedHabitat.id, // Передаем ID вольера
    );

    // Обновляем вольер - добавляем ID крокодила
    habitatCubit.addCrocodileToHabitat(
      selectedHabitat.id,
      newCrocodileId,
    );

    // Показываем подтверждение
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Крокодил успешно добавлен'),
        backgroundColor: Colors.green,
      ),
    );

    // Возвращаемся назад
    Future.delayed(const Duration(milliseconds: 500), () {
      context.pop();
    });
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Заголовок
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

                    // Выбор вольера - УПРОЩЕННАЯ ВЕРСИЯ
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
                          child: Text(
                            'Выберите вольер:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        if (_availableHabitats.isEmpty)
                          Card(
                            color: Colors.orange[50],
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.warning,
                                    color: Colors.orange,
                                    size: 40,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Нет доступных вольеров',
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Сначала создайте вольер в разделе "Среда обитания"',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedHabitatId,
                                isExpanded: true,
                                isDense: true,
                                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                icon: const Icon(Icons.arrow_drop_down, color: Colors.green),
                                items: _availableHabitats.map((habitat) {
                                  return DropdownMenuItem<String>(
                                    value: habitat.id,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                      child: Text(
                                        habitat.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedHabitatId = newValue;
                                  });
                                },
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Состояние здоровья
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Кнопка добавления
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
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
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