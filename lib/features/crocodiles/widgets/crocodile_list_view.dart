import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../cubit/crocodile_cubit.dart';
import 'crocodile_tile.dart';

class CrocodileListView extends StatelessWidget {
  const CrocodileListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrocodileCubit, CrocodileState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              height: 200,
              width: 200,
              child: CachedNetworkImage(
                imageUrl: 'https://masterpiecer-images.s3.yandex.net/eb0fb74e89be11eeb35f1ad242dc1d78:upscaled',
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
                itemCount: state.crocodiles.length,
                itemBuilder: (context, index) {
                  final crocodile = state.crocodiles[index];
                  final cubit = context.read<CrocodileCubit>();
                  return CrocodileTile(
                    crocodile: crocodile,
                    onDelete: () => cubit.deleteCrocodile(crocodile.id),
                    onChangeStatus: (newStatus) => cubit.changeStatus(crocodile.id, newStatus),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}