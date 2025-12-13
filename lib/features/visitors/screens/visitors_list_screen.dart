// features/visitors/screens/visitors_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project/service_locator.dart';
import '../cubit/visitor_cubit.dart';
import '../widgets/visitor_card.dart';

class VisitorsListScreen extends StatelessWidget {
  const VisitorsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator<VisitorCubit>(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text('Посетители'),
        ),
        body: BlocBuilder<VisitorCubit, VisitorState>(
          builder: (context, state) {
            if (state.visitors.isEmpty) {
              return const Center(
                child: Text('Посетителей пока нет'),
              );
            }

            // Считаем статистику
            final totalVisitors = state.visitors.length;
            final totalTickets = state.visitors.fold(
                0, (sum, visitor) => sum + visitor.ticketCount);
            final totalRevenue = state.visitors.fold(
                0.0, (sum, visitor) => sum + visitor.totalPrice);

            return Column(
              children: [
                _buildStatsCard(totalVisitors, totalTickets, totalRevenue),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.visitors.length,
                    itemBuilder: (context, index) {
                      final visitor = state.visitors[index];
                      final cubit = context.read<VisitorCubit>();
                      return VisitorCard(
                        visitor: visitor,
                        onDelete: () => cubit.deleteVisitor(visitor.id),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push('/visitors/add'),
          child: const Icon(Icons.person_add),
        ),
      ),
    );
  }

  Widget _buildStatsCard(int totalVisitors, int totalTickets, double totalRevenue) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('Посетителей', totalVisitors.toString(), Icons.people),
            _buildStatItem('Билетов', totalTickets.toString(), Icons.confirmation_number),
            _buildStatItem('Выручка', '${totalRevenue.toInt()} ₽', Icons.attach_money),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.green, size: 24),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}