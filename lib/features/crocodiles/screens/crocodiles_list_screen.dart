import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/models/crocodile.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';
import 'package:project/features/crocodiles/widgets/crocodile_list_view.dart';

class CrocodilesListScreen extends StatelessWidget {
  const CrocodilesListScreen({
    super.key,
    required this.crocodiles,
    required this.onAdd,
    required this.onChangeStatus,
  });

  final List<Crocodile> crocodiles;
  final VoidCallback onAdd;
  final void Function(String id, CrocodileStatus status) onChangeStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Учет крокодилов'),
      ),
      body: CrocodileListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: onAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}
