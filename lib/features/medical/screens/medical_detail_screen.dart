// features/medical/screens/medical_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project/service_locator.dart';
import '../cubit/medical_cubit.dart';
import '../models/medical_record.dart';

class MedicalDetailScreen extends StatelessWidget {
  final String recordId;

  const MedicalDetailScreen({super.key, required this.recordId});

  @override
  Widget build(BuildContext context) {
    final medicalCubit = locator<MedicalCubit>();
    final record = medicalCubit.state.records
        .firstWhere((r) => r.id == recordId, orElse: () => MedicalRecord(
      id: '',
      crocodileId: '',
      crocodileName: '',
      date: DateTime.now(),
      diagnosis: '',
      treatment: '',
      veterinarian: '',
    ));

    if (record.id.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text('Запись не найдена'),
        ),
        body: const Center(
          child: Text('Медицинская запись не найдена'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Запись: ${record.crocodileName}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Здесь можно добавить редактирование
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Редактирование'),
                  content: const Text('Функционал редактирования'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Статус записи
            Card(
              color: record.isCompleted ? Colors.green.shade50 : Colors.orange.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      record.isCompleted ? Icons.check_circle : Icons.timelapse,
                      color: record.isCompleted ? Colors.green : Colors.orange,
                      size: 30,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            record.isCompleted ? 'Лечение завершено' : 'Лечение в процессе',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Дата: ${record.day}.${record.month}.${record.year}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    if (!record.isCompleted)
                      ElevatedButton(
                        onPressed: () {
                          medicalCubit.markAsCompleted(record.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Лечение отмечено как завершенное'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        child: const Text('Завершить'),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Информация о крокодиле
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Крокодил:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.psychology, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          record.crocodileName,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Диагноз
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Диагноз:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      record.diagnosis,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Лечение
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Назначенное лечение:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      record.treatment,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Ветеринар
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ветеринар:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          record.veterinarian,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Дополнительные заметки
            if (record.notes != null && record.notes!.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Дополнительные заметки:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(record.notes!),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}