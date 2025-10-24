import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:project/features/habitats/models/crocodile_habitat.dart';

class HabitatCard extends StatelessWidget {
  final CrocodileHabitat habitat;

  const HabitatCard({super.key, required this.habitat});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 200,
            child: CachedNetworkImage(
              imageUrl: habitat.imageUrl,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) =>
              const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(habitat.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                const SizedBox(height: 8),
                Text(habitat.description),
                const SizedBox(height: 8),
                Text('Температура: ${habitat.temperature}°C'),
                Text('Влажность: ${habitat.humidity}%'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}