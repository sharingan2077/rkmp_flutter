// features/medical/widgets/medical_record_card.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/features/medical/models/medical_record.dart';

class MedicalRecordCard extends StatelessWidget {
  final MedicalRecord record;

  const MedicalRecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push('/medical/${record.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Крокодил: ${record.crocodileName}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: record.isCompleted ? Colors.green[100] : Colors.orange[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      record.isCompleted ? 'Завершено' : 'В процессе',
                      style: TextStyle(
                        color: record.isCompleted ? Colors.green[800] : Colors.orange[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Диагноз: ${record.diagnosis}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Лечение: ${record.treatment.length > 50 ? '${record.treatment.substring(0, 50)}...' : record.treatment}',
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.person, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    record.veterinarian,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const Spacer(),
                  Text(
                    '${record.day}.${record.month}.${record.year}',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
              if (record.notes != null && record.notes!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.note, size: 14, color: Colors.blue),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              record.notes!,
                              style: const TextStyle(fontSize: 12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 4),
              const Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Подробнее',
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                    Icon(Icons.arrow_forward, size: 12, color: Colors.green),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}