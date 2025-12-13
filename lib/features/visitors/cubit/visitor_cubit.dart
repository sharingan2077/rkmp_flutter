// features/visitors/cubit/visitor_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/visitor_dart.dart';

class VisitorState {
  final List<Visitor> visitors;
  final bool isLoading;

  const VisitorState({
    this.visitors = const [],
    this.isLoading = false,
  });

  VisitorState copyWith({
    List<Visitor>? visitors,
    bool? isLoading,
  }) {
    return VisitorState(
      visitors: visitors ?? this.visitors,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class VisitorCubit extends Cubit<VisitorState> {
  VisitorCubit() : super(const VisitorState()) {
    _initializeSampleData();
  }

  void _initializeSampleData() {
    final sampleVisitors = [
      Visitor(
        id: '1',
        name: 'Иванов Иван',
        visitDate: DateTime(2024, 12, 12),
        ticketCount: 2,
        totalPrice: 1000.0,
        ticketType: 'Взрослый',
      ),
      Visitor(
        id: '2',
        name: 'Петрова Мария',
        visitDate: DateTime(2024, 12, 11),
        ticketCount: 3,
        totalPrice: 1350.0,
        ticketType: 'Семейный',
      ),
    ];

    emit(state.copyWith(visitors: sampleVisitors));
  }

  void addVisitor(Visitor visitor) {
    final updatedVisitors = List<Visitor>.from(state.visitors)..add(visitor);
    emit(state.copyWith(visitors: updatedVisitors));
  }

  void deleteVisitor(String id) {
    final updatedVisitors = state.visitors.where((v) => v.id != id).toList();
    emit(state.copyWith(visitors: updatedVisitors));
  }
}