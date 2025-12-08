import 'package:hive_ce_flutter/hive_flutter.dart';
part 'daily_log.g.dart';

@HiveType(typeId: 1)
class DailyLog extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final Map<String, int> completed; // habitId -> count (pages, glasses, reps)

  @HiveField(2)
  final int streak;

  DailyLog({
    required this.date,
    required this.completed,
    required this.streak,
  });

  factory DailyLog.today({required Map<String, int> completed, required int streak}) {
    return DailyLog(
      date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      completed: completed,
      streak: streak,
    );
  }
}