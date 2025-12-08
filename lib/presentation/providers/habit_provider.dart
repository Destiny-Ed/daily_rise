import 'package:daily_rise/data/local/hive_boxes.dart';
import 'package:daily_rise/data/models/habits_model.dart';
import 'package:daily_rise/data/repositories/local_repository.dart';
import 'package:daily_rise/data/repository_impl/local_repository_impl.dart';
import 'package:flutter/material.dart';

class HabitProvider extends ChangeNotifier {
  final LocalRepository _repo = LocalRepositoryImpl();

  List<Habit> habits = [];
  int streak = 0;
  bool isFirstTime = true;
  Map<String, bool> todayCompleted = {};

  Future<void> init() async {
    isFirstTime = await _repo.isFirstTime();
    if (!isFirstTime) {
      await loadData();
    }
    notifyListeners();
  }

  Future<void> loadData() async {
    habits = await _repo.getHabits();
    streak = await _repo.getStreak();
    todayCompleted = await _repo.getTodayCompleted();
    _updateStreakIfNeeded();
    notifyListeners();
  }

  Future<void> saveHabitsSetup(List<Habit> newHabits) async {
    habits = newHabits;
    await _repo.saveHabits(habits);
    await _repo.markOnboarded();
    isFirstTime = false;
    notifyListeners();
  }

  Future<void> completeHabit(String habitId) async {
    await _repo.markHabitComplete(habitId);
    todayCompleted[habitId] = true;
    _updateStreakIfNeeded();
    notifyListeners();
  }

  void _updateStreakIfNeeded() {
    final today = DateTime.now();
    final lastDateStr = HiveBoxes.box.get('last_date');
    if (lastDateStr == null) return;

    final lastDate = DateTime.parse(lastDateStr);
    if (today.difference(lastDate).inDays == 1) {
      streak += 1;
    } else if (today.difference(lastDate).inDays > 1) {
      streak = 1;
    }
    HiveBoxes.box.put('streak', streak);
    HiveBoxes.box.put('last_date', today.toIso8601String());
  }
}
