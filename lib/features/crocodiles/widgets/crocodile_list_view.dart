import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:project/features/shared_state/crocodile_provider.dart';
import 'package:provider/provider.dart';
import 'package:project/features/crocodiles/widgets/crocodile_tile.dart';

class CrocodileListView extends StatelessWidget {
  const CrocodileListView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CrocodileProvider>(context);

    return Column(
      children: [
        Container(
          height: 200,
          width: 200,
          child: CachedNetworkImage(
            imageUrl: 'https://masterpiecer-images.s3.yandex.net/eb0fb74e89be11eeb35f1ad242dc1d78:upscaled', // или вынеси в константу
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
            itemCount: provider.crocodiles.length,
            itemBuilder: (context, index) {
              final crocodile = provider.crocodiles[index];
              return CrocodileTile(
                crocodile: crocodile,
                onDelete: () => provider.deleteCrocodile(crocodile.id),
                onChangeStatus: (newStatus) => provider.changeStatus(crocodile.id, newStatus),
              );
            },
          ),
        ),
      ],
    );
  }
}