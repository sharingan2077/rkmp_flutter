import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/service_locator.dart';
import '../../crocodiles/cubit/crocodile_cubit.dart';
import '../../crocodiles/models/crocodile_status.dart';
import 'status_chip.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrocodileCubit, CrocodileState>(
      bloc: locator<CrocodileCubit>(),
      builder: (context, state) {
        final statusCounts = locator<CrocodileCubit>().getStatusCounts();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StatusChip(
                title: 'Всего особей',
                value: state.crocodiles.length,
                icon: Icons.psychology,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              StatusChip(
                title: 'Здоровы',
                value: statusCounts[CrocodileStatus.healthy] ?? 0,
                icon: Icons.verified,
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              StatusChip(
                title: 'Требуют осмотра',
                value: statusCounts[CrocodileStatus.needCheckup] ?? 0,
                icon: Icons.medical_information,
                color: Colors.orange,
              ),
              const SizedBox(height: 16),
              StatusChip(
                title: 'На лечении',
                value: statusCounts[CrocodileStatus.treatment] ?? 0,
                icon: Icons.local_hospital,
                color: Colors.red,
              ),
            ],
          ),
        );
      },
    );
  }
}