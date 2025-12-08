import 'package:daily_rise/data/models/habits_model.dart';


abstract class LocalRepository {
  Future<List<Habit>> getHabits();
  Future<void> saveHabits(List<Habit> habits);
  Future<bool> isFirstTime();
  Future<void> markOnboarded();
  Future<int> getStreak();
  Future<void> updateStreak(int streak, DateTime date);
  Future<Map<String, bool>> getTodayCompleted();
  Future<void> markHabitComplete(String habitId);
}