import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/models/crocodile.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';
import 'package:project/features/crocodiles/widgets/crocodile_tile.dart';

class CrocodileListView extends StatelessWidget {
  const CrocodileListView({super.key, required this.crocodiles, required this.onDelete, required this.onChangeStatus});

  final List<Crocodile> crocodiles;
  final ValueChanged<String> onDelete;
  final void Function(String id, CrocodileStatus status) onChangeStatus;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: crocodiles.length,
      itemBuilder: (context, index) {
        final crocodile = crocodiles[index];
        return CrocodileTile(
          crocodile: crocodile,
          onDelete: (id) => onDelete(crocodile.id),
          onChangeStatus: (id, newStatus) => onChangeStatus(id, newStatus),
        );
      },
    );
  }
}
