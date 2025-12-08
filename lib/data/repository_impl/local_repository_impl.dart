import 'package:daily_rise/data/models/habits_model.dart';
import 'package:daily_rise/data/repositories/local_repository.dart';
import '../local/hive_boxes.dart';

class LocalRepositoryImpl implements LocalRepository {
  @override
  Future<List<Habit>> getHabits() async => HiveBoxes.getHabits();

  @override
  Future<void> saveHabits(List<Habit> habits) async =>
      HiveBoxes.saveHabits(habits);

  @override
  Future<bool> isFirstTime() async =>
      HiveBoxes.box.get('habits_set', defaultValue: false) == false;

  @override
  Future<void> markOnboarded() async => HiveBoxes.box.put('habits_set', true);

  @override
  Future<int> getStreak() async => HiveBoxes.box.get('streak', defaultValue: 0);

  @override
  Future<void> updateStreak(int streak, DateTime date) async {
    await HiveBoxes.box.put('streak', streak);
    await HiveBoxes.box.put('last_date', date.toIso8601String());
  }

  @override
  Future<Map<String, bool>> getTodayCompleted() async {
    return Map<String, bool>.from(
      HiveBoxes.box.get('today', defaultValue: <String, bool>{}),
    );
  }

  @override
  Future<void> markHabitComplete(String habitId) async {
    final today = Map<String, bool>.from(await getTodayCompleted());
    today[habitId] = true;
    await HiveBoxes.box.put('today', today);
  }
}
