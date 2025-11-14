import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

class AppStateService {
  int totalCrocodiles = 0;
  int healthyCrocodiles = 0;
  int crocodilesNeedCheckup = 0;
  int crocodilesOnTreatment = 0;

  void updateStats({
    int? totalCrocodiles,
    int? healthyCrocodiles,
    int? crocodilesNeedCheckup,
    int? crocodilesOnTreatment,
  }) {
    this.totalCrocodiles = totalCrocodiles ?? this.totalCrocodiles;
    this.healthyCrocodiles = healthyCrocodiles ?? this.healthyCrocodiles;
    this.crocodilesNeedCheckup = crocodilesNeedCheckup ?? this.crocodilesNeedCheckup;
    this.crocodilesOnTreatment = crocodilesOnTreatment ?? this.crocodilesOnTreatment;
  }
}

void setupLocator() {
  locator.registerSingleton<AppStateService>(AppStateService());
}