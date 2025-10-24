import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/features/crocodiles/models/crocodile.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';
import 'package:project/features/crocodiles/widgets/crocodile_tile.dart';

class CrocodileListView extends StatelessWidget {
  const CrocodileListView({
    super.key,
    required this.crocodiles,
    required this.onDelete,
    required this.onChangeStatus,
    required this.imageUrl,
  });

  final List<Crocodile> crocodiles;
  final ValueChanged<String> onDelete;
  final void Function(String id, CrocodileStatus status) onChangeStatus;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: 200,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, progress) =>
            const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Center(
              child: Icon(
                Icons.image,
                color: Colors.grey,
                size: 50,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: crocodiles.length,
            itemBuilder: (context, index) {
              final crocodile = crocodiles[index];
              return CrocodileTile(
                crocodile: crocodile,
                onDelete: (id) => onDelete(crocodile.id),
                onChangeStatus: (id, newStatus) => onChangeStatus(id, newStatus),
              );
            },
          ),
        ),
      ],
    );
  }
}