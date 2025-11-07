import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/features/shared_state/crocodile_provider.dart';
import 'package:provider/provider.dart';
import 'package:project/features/habitats/widgets/habitat_card.dart';

class CrocodileHabitatScreen extends StatelessWidget {
  const CrocodileHabitatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CrocodileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(), // Вертикальная навигация - назад
        ),
        title: const Text('Среда обитания'),
      ),
      body: ListView.builder(
        itemCount: provider.habitats.length,
        itemBuilder: (context, index) {
          final habitat = provider.habitats[index];
          return HabitatCard(habitat: habitat);
        },
      ),
    );
  }
}