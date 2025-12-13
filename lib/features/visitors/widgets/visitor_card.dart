// features/visitors/widgets/visitor_card.dart
import 'package:flutter/material.dart';

import '../models/visitor_dart.dart';

class VisitorCard extends StatelessWidget {
  final Visitor visitor;
  final VoidCallback onDelete;

  const VisitorCard({
    super.key,
    required this.visitor,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  visitor.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildInfoItem('Дата', '${visitor.day}.${visitor.month}.${visitor.year}'),
                const SizedBox(width: 16),
                _buildInfoItem('Билетов', '${visitor.ticketCount}'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                _buildInfoItem('Тип билета', visitor.ticketType),
                const SizedBox(width: 16),
                _buildInfoItem('Сумма', '${visitor.totalPrice} ₽'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}