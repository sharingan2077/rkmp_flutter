// features/medical/screens/add_medical_record_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project/service_locator.dart';
import '../cubit/medical_cubit.dart';
import '../models/medical_record.dart';
import 'package:project/features/crocodiles/cubit/crocodile_cubit.dart';

class AddMedicalRecordScreen extends StatefulWidget {
  const AddMedicalRecordScreen({super.key});

  @override
  State<AddMedicalRecordScreen> createState() => _AddMedicalRecordScreenState();
}

class _AddMedicalRecordScreenState extends State<AddMedicalRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  late var _diagnosisController = TextEditingController();
  final _treatmentController = TextEditingController();
  final _veterinarianController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedCrocodileId;
  DateTime _selectedDate = DateTime.now();
  bool _isCompleted = false;

  List<String> _commonDiagnoses = [
    'Профилактический осмотр',
    'Вакцинация',
    'Травма',
    'Инфекция',
    'Паразиты',
    'Проблемы с пищеварением',
    'Дерматит',
    'Стоматологические проблемы'
  ];

  @override
  void dispose() {
    _diagnosisController.dispose();
    _treatmentController.dispose();
    _veterinarianController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCrocodileId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Выберите крокодила')),
      );
      return;
    }

    final crocodileCubit = locator<CrocodileCubit>();
    final crocodile = crocodileCubit.state.crocodiles
        .firstWhere((c) => c.id == _selectedCrocodileId);

    final medicalRecord = MedicalRecord(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      crocodileId: crocodile.id,
      crocodileName: crocodile.name,
      date: _selectedDate,
      diagnosis: _diagnosisController.text.trim(),
      treatment: _treatmentController.text.trim(),
      veterinarian: _veterinarianController.text.trim(),
      notes: _notesController.text.trim(),
      isCompleted: _isCompleted,
    );

    final medicalCubit = locator<MedicalCubit>();
    medicalCubit.addRecord(medicalRecord);

    // Показываем подтверждение
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Медицинская запись добавлена'),
        backgroundColor: Colors.green,
      ),
    );

    // Возвращаемся назад
    Future.delayed(const Duration(milliseconds: 500), () {
      context.pop();
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024, 1, 1),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final crocodileCubit = locator<CrocodileCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить медицинскую запись'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Выбор крокодила
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Выберите крокодила:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedCrocodileId,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Выберите крокодила',
                        ),
                        items: crocodileCubit.state.crocodiles.map((croc) {
                          return DropdownMenuItem<String>(
                            value: croc.id,
                            child: Row(
                              children: [
                                const Icon(Icons.psychology, size: 16),
                                const SizedBox(width: 8),
                                Text(croc.name),
                                const SizedBox(width: 8),
                                Text(
                                  '(${croc.species})',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCrocodileId = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Выберите крокодила';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Дата осмотра
              InkWell(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Дата осмотра',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_selectedDate.day.toString().padLeft(2, '0')}.'
                            '${_selectedDate.month.toString().padLeft(2, '0')}.'
                            '${_selectedDate.year}',
                      ),
                      const Icon(Icons.calendar_month),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Диагноз с подсказками
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  return _commonDiagnoses.where((diagnosis) {
                    return diagnosis.toLowerCase().contains(
                      textEditingValue.text.toLowerCase(),
                    );
                  });
                },
                onSelected: (String selection) {
                  _diagnosisController.text = selection;
                },
                fieldViewBuilder: (
                    BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted,
                    ) {
                  _diagnosisController = textEditingController;
                  return TextFormField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      labelText: 'Диагноз',
                      prefixIcon: Icon(Icons.medical_services),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите диагноз';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),

              // Лечение
              TextFormField(
                controller: _treatmentController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Назначенное лечение',
                  prefixIcon: Icon(Icons.medication),
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите назначенное лечение';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Ветеринар
              TextFormField(
                controller: _veterinarianController,
                decoration: const InputDecoration(
                  labelText: 'Ветеринар',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите имя ветеринара';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Дополнительные заметки
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Дополнительные заметки (опционально)',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 16),

              // Статус завершения
              SwitchListTile(
                title: const Text('Завершено лечение'),
                subtitle: const Text('Отметьте если лечение завершено'),
                value: _isCompleted,
                onChanged: (value) {
                  setState(() {
                    _isCompleted = value;
                  });
                },
                secondary: Icon(
                  _isCompleted ? Icons.check_circle : Icons.timelapse,
                  color: _isCompleted ? Colors.green : Colors.orange,
                ),
              ),
              const SizedBox(height: 24),

              // Кнопка добавления
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Добавить медицинскую запись',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}