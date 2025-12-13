// features/habitats/widgets/habitat_card.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:project/features/habitats/models/crocodile_habitat.dart';

class HabitatCard extends StatelessWidget {
  final CrocodileHabitat habitat;

  const HabitatCard({super.key, required this.habitat});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => context.push('/habitats/${habitat.id}'),
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
                  child: Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        habitat.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(habitat.description),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildInfoChip(
                        icon: Icons.thermostat,
                        text: '${habitat.temperature}°C',
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        icon: Icons.water_drop,
                        text: '${habitat.humidity}%',
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        icon: Icons.psychology,
                        text: '${habitat.crocodileIds.length} крок.',
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ],
      ),
    );
  }
}