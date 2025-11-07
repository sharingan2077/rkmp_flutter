import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/features/crocodiles/widgets/crocodile_list_view.dart';
import 'package:project/features/shared_state/crocodile_provider.dart';
import 'package:provider/provider.dart';

class CrocodilesListScreen extends StatelessWidget {
  const CrocodilesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(), // Вертикальная навигация - назад
        ),
        title: const Text('Учет крокодилов'),
      ),
      body: const CrocodileListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/crocodiles/form'), // Вертикальная навигация
        child: const Icon(Icons.add),
      ),
    );
  }
}