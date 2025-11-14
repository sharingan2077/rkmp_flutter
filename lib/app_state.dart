import 'package:flutter/material.dart';

class AppState extends InheritedWidget {
  final int totalCrocodiles;
  final int healthyCrocodiles;
  final int crocodilesNeedCheckup;
  final int crocodilesOnTreatment;

  const AppState({
    super.key,
    required this.totalCrocodiles,
    required this.healthyCrocodiles,
    required this.crocodilesNeedCheckup,
    required this.crocodilesOnTreatment,
    required super.child,
  });

  static AppState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppState>();
    assert(result != null, 'No AppState found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant AppState oldWidget) {
    return totalCrocodiles != oldWidget.totalCrocodiles ||
        healthyCrocodiles != oldWidget.healthyCrocodiles ||
        crocodilesNeedCheckup != oldWidget.crocodilesNeedCheckup ||
        crocodilesOnTreatment != oldWidget.crocodilesOnTreatment;
  }
}