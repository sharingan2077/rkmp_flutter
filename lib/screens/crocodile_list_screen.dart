import 'package:flutter/material.dart';
import '../models/crocodile.dart';
import '../widgets/crocodile_card.dart';
import 'add_crocodile_screen.dart';

class CrocodileListScreen extends StatefulWidget {
  const CrocodileListScreen({super.key});

  @override
  State<CrocodileListScreen> createState() => _CrocodileListScreenState();
}

class _CrocodileListScreenState extends State<CrocodileListScreen> {
  final List<Crocodile> _crocodiles = [
    Crocodile(
      id: '1',
      name: 'Гена',
      species: 'Нильский крокодил',
      age: 15,
      length: 4.2,
      weight: 450.0,
      healthStatus: 'Здоров',
      lastFed: DateTime.now().subtract(const Duration(days: 1)),
      enclosure: 'A1',
    ),
    Crocodile(
      id: '2',
      name: 'Клава',
      species: 'Миссисипский аллигатор',
      age: 12,
      length: 2.8,
      weight: 180.0,
      healthStatus: 'Требует осмотра',
      lastFed: DateTime.now().subtract(const Duration(days: 3)),
      enclosure: 'B2',
    ),
  ];

  void _addCrocodile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCrocodileScreen(
          onCrocodileAdded: (crocodile) {
            setState(() {
              _crocodiles.add(crocodile);
            });
          },
        ),
      ),
    );
  }

  void _removeCrocodile(String id) {
    setState(() {
      _crocodiles.removeWhere((croc) => croc.id == id);
    });
  }

  void _updateCrocodileHealth(String id, String newStatus) {
    setState(() {
      final index = _crocodiles.indexWhere((croc) => croc.id == id);
      if (index != -1) {
        _crocodiles[index] = _crocodiles[index].copyWith(healthStatus: newStatus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Учет крокодилов'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addCrocodile,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _crocodiles.length,
        itemBuilder: (context, index) {
          final crocodile = _crocodiles[index];
          return CrocodileCard(
            crocodile: crocodile,
            onRemove: () => _removeCrocodile(crocodile.id),
            onHealthUpdate: (newStatus) => _updateCrocodileHealth(crocodile.id, newStatus),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCrocodile,
        child: const Icon(Icons.add),
      ),
    );
  }
}