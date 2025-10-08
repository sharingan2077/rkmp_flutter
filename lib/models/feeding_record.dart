class FeedingRecord {
  final String id;
  final String crocodileId;
  final DateTime date;
  final String foodType;
  final double amount;
  final bool completed;

  FeedingRecord({
    required this.id,
    required this.crocodileId,
    required this.date,
    required this.foodType,
    required this.amount,
    required this.completed,
  });
}