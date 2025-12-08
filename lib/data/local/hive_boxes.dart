import 'package:daily_rise/data/models/habits_model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class HiveBoxes {
  static late Box box;

  static Future<void> init() async {
    box = await Hive.openBox('dailyrise_box');
  }

  static List<Habit> getHabits() {
    final raw = box.get(
      'habits',
      defaultValue: <Map>[].cast<Map<String, dynamic>>(),
    );
    return raw.map<Habit>((e) => Habit.fromJson(e)).toList();
  }

  static Future<void> saveHabits(List<Habit> habits) async {
    await box.put('habits', habits.map((h) => h.toJson()).toList());
  }
}
