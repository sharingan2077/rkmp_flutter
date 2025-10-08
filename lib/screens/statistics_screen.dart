import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Статистика')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildStatCard('Общее количество', '24 особи', Icons.psychology),
            _buildStatCard('Средний возраст', '12.5 лет', Icons.calendar_today),
            _buildStatCard('Средний вес', '285 кг', Icons.scale),
            _buildStatCard('Средняя длина', '3.2 м', Icons.straighten),
            _buildStatCard('Требуют внимания', '3 особи', Icons.medical_services),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.green),
        title: Text(title),
        subtitle: Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}