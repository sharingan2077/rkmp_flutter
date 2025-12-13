import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/crocodile_cubit.dart';
import 'crocodile_tile.dart';

class CrocodileListView extends StatelessWidget {
  const CrocodileListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrocodileCubit, CrocodileState>(
      builder: (context, state) {
        if (state.crocodiles.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.psychology, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Крокодилов пока нет',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Text(
                  'Добавьте первого крокодила',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
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
        );
      },
    );
  }
}