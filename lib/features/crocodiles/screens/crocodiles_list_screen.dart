import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/features/crocodiles/models/crocodile.dart';
import 'package:project/features/crocodiles/models/crocodile_status.dart';
import 'package:project/features/crocodiles/widgets/crocodile_list_view.dart';
import 'package:project/features/shared_state/crocodile_provider.dart';
import 'package:provider/provider.dart';

class CrocodilesListScreen extends StatelessWidget {
  const CrocodilesListScreen({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CrocodileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Учет крокодилов'),),
      body: CrocodileListView(
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => context.push('/crocodiles/form'),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}