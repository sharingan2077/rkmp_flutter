// features/habitats/screens/habitat_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:project/features/habitats/models/crocodile_habitat.dart';
import 'package:project/service_locator.dart';
import 'package:project/features/crocodiles/cubit/crocodile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HabitatDetailScreen extends StatelessWidget {
  final CrocodileHabitat habitat;

  const HabitatDetailScreen({super.key, required this.habitat});

  @override
  Widget build(BuildContext context) {
    final crocodileCubit = locator<CrocodileCubit>();
    final crocodilesInHabitat = crocodileCubit.state.crocodiles
        .where((croc) => habitat.crocodileIds.contains(croc.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(habitat.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 250,
              child: CachedNetworkImage(
                imageUrl: habitat.imageUrl,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habitat.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    habitat.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Температура', '${habitat.temperature}°C'),
                  _buildInfoRow('Влажность', '${habitat.humidity}%'),
                  _buildInfoRow('Крокодилов в вольере', crocodilesInHabitat.length.toString()),
                  const SizedBox(height: 16),
                  const Text(
                    'Крокодилы в этом вольере:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (crocodilesInHabitat.isEmpty)
                    const Text('В этом вольере пока нет крокодилов'),
                  ...crocodilesInHabitat.map((croc) => ListTile(
                    title: Text(croc.name),
                    subtitle: Text('${croc.species}, ${croc.age} лет'),
                    leading: const Icon(Icons.psychology, color: Colors.green),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}