import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/habitat_cubit.dart';
import '../widgets/habitat_card.dart';

class CrocodileHabitatScreen extends StatelessWidget {
  const CrocodileHabitatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Среда обитания'),
      ),
      body: BlocBuilder<HabitatCubit, HabitatState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.habitats.length,
            itemBuilder: (context, index) {
              final habitat = state.habitats[index];
              return HabitatCard(habitat: habitat);
            },
          );
        },
      ),
    );
  }
}
