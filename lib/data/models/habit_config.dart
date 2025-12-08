import 'package:hive_ce_flutter/hive_flutter.dart';
part 'habit_config.g.dart';

@HiveType(typeId: 0)
class HabitConfig extends HiveObject {
  @HiveField(0)
  final String id; // "reading", "water", "workout"

  @HiveField(1)
  final String name;

  @HiveField(2)
  final bool isActive;

  @HiveField(3)
  final int target; // pages, glasses, reps

  @HiveField(4)
  final String? bookTitle;

  @HiveField(5)
  final String? workoutType; // push-ups, squats, etc.

  @HiveField(6)
  final List<String> musicGenres;

  HabitConfig({
    required this.id,
    required this.name,
    required this.isActive,
    required this.target,
    this.bookTitle,
    this.workoutType,
    this.musicGenres = const [],
  });
}