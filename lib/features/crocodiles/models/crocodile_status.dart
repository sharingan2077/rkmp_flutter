enum CrocodileStatus {
  healthy('Здоров'),
  needCheckup('Требует осмотра'),
  treatment('На лечении');

  const CrocodileStatus(this.label);

  final String label;

  static CrocodileStatus? fromString(String value) {
    try {
      return CrocodileStatus.values.firstWhere(
            (status) => status.name == value,
      );
    } catch (e) {
      return null;
    }
  }
}