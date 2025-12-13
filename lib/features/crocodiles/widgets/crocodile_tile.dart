import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:project/features/crocodiles/models/crocodile.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';

class CrocodileTile extends StatelessWidget {
  const CrocodileTile({
    super.key,
    required this.crocodile,
    required this.onDelete,
    required this.onChangeStatus,
  });

  final Crocodile crocodile;
  final VoidCallback onDelete;
  final ValueChanged<CrocodileStatus> onChangeStatus;

  // Единый URL для всех крокодилов
  static const String crocodileImageUrl = 'https://avatars.mds.yandex.net/i?id=8624df07b26f1b969050c63d071bbe50_l-9068831-images-thumbs&n=13';

  Color _getStatusColor() {
    switch (crocodile.status) {
      case CrocodileStatus.healthy:
        return Colors.green;
      case CrocodileStatus.needCheckup:
        return Colors.orange;
      case CrocodileStatus.treatment:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Фотография крокодила
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: crocodileImageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.psychology, color: Colors.grey),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Основная информация
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        crocodile.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                        onPressed: onDelete,
                      ),
                    ],
                  ),
                  Text(
                    crocodile.species,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),

                  // Информация в две колонки
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow('Возраст', '${crocodile.age} лет'),
                          _buildInfoRow('Длина', '${crocodile.length} м'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow('Вес', '${crocodile.weight} кг'),
                          _buildInfoRow('Вольер', crocodile.enclosure),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor().withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          crocodile.status.label,
                          style: TextStyle(
                            color: _getStatusColor(),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      PopupMenuButton<CrocodileStatus>(
                        icon: const Icon(Icons.more_vert, size: 20),
                        onSelected: onChangeStatus,
                        itemBuilder: (BuildContext context) =>
                            CrocodileStatus.values.map((status) {
                              return PopupMenuItem(
                                value: status,
                                child: Text(status.label),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 14, color: Colors.black),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(color: Colors.grey),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}