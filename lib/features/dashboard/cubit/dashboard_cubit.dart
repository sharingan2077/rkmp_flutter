import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardState {
  final int totalCrocodiles;
  final int healthyCrocodiles;
  final int crocodilesNeedCheckup;
  final int crocodilesOnTreatment;

  const DashboardState({
    this.totalCrocodiles = 0,
    this.healthyCrocodiles = 0,
    this.crocodilesNeedCheckup = 0,
    this.crocodilesOnTreatment = 0,
  });

  DashboardState copyWith({
    int? totalCrocodiles,
    int? healthyCrocodiles,
    int? crocodilesNeedCheckup,
    int? crocodilesOnTreatment,
  }) {
    return DashboardState(
      totalCrocodiles: totalCrocodiles ?? this.totalCrocodiles,
      healthyCrocodiles: healthyCrocodiles ?? this.healthyCrocodiles,
      crocodilesNeedCheckup: crocodilesNeedCheckup ?? this.crocodilesNeedCheckup,
      crocodilesOnTreatment: crocodilesOnTreatment ?? this.crocodilesOnTreatment,
    );
  }
}

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());

  void updateStats({
    int? totalCrocodiles,
    int? healthyCrocodiles,
    int? crocodilesNeedCheckup,
    int? crocodilesOnTreatment,
  }) {
    emit(state.copyWith(
      totalCrocodiles: totalCrocodiles,
      healthyCrocodiles: healthyCrocodiles,
      crocodilesNeedCheckup: crocodilesNeedCheckup,
      crocodilesOnTreatment: crocodilesOnTreatment,
    ));
  }
}