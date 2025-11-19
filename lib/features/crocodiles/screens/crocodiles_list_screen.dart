import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project/service_locator.dart';
import '../cubit/crocodile_cubit.dart';
import '../widgets/crocodile_list_view.dart';

class CrocodilesListScreen extends StatelessWidget {
  const CrocodilesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator<CrocodileCubit>(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text('Учет крокодилов'),
        ),
        body: const CrocodileListView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push('/crocodiles/form'),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}