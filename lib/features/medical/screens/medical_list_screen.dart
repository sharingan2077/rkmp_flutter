// features/medical/screens/medical_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project/service_locator.dart';
import '../cubit/medical_cubit.dart';
import '../widgets/medical_record_card.dart';

class MedicalListScreen extends StatelessWidget {
  const MedicalListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator<MedicalCubit>(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text('Медицинские записи'),
        ),
        body: BlocBuilder<MedicalCubit, MedicalState>(
          builder: (context, state) {
            if (state.records.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.medical_services, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text(
                      'Медицинских записей пока нет',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => context.push('/medical/add'),
                      child: const Text('Добавить первую запись'),
                    ),
                  ],
                ),
              );
            }

            final stats = context.read<MedicalCubit>().getStats();

            return Column(
              children: [
                // Статистика
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Статистика:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem(
                              'Всего',
                              stats['total'].toString(),
                              Icons.list,
                              Colors.blue,
                            ),
                            _buildStatItem(
                              'Завершено',
                              stats['completed'].toString(),
                              Icons.check_circle,
                              Colors.green,
                            ),
                            _buildStatItem(
                              'В процессе',
                              stats['inProgress'].toString(),
                              Icons.timelapse,
                              Colors.orange,
                            ),
                          ],
                        ),
                        if (stats['topDiagnoses'].isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12),
                              const Text(
                                'Частые диагнозы:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              ...(stats['topDiagnoses'] as List<String>).map(
                                    (diagnosis) => Text(
                                  '• $diagnosis',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),

                // Список записей
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.records.length,
                    itemBuilder: (context, index) {
                      final record = state.records[index];
                      return MedicalRecordCard(record: record);
                    },
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push('/medical/add'),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}