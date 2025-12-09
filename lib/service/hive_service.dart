import 'package:daily_rise/data/models/workout_model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import '../data/models/habit_config.dart';
import '../data/models/daily_log.dart';

class HiveService {
  // Box names
  static const String _configBox = 'config_box';        // Main habits (reading, water, workout summary)
  static const String _logsBox = 'logs_box';            // Daily logs + streak
  static const String _userPrefsBox = 'user_prefs_box'; // For List<WorkoutModel>, genres, etc.

  static late Box<HabitConfig> _config;
  static late Box<DailyLog> _logs;
  static late Box _prefs; // Dynamic box (stores Map, List, String, etc.)

  static Future<void> init() async {
    await Hive.initFlutter();

    // Register only typed adapters
    Hive.registerAdapter(HabitConfigAdapter());
    Hive.registerAdapter(DailyLogAdapter());

    // Open boxes
    _config = await Hive.openBox<HabitConfig>(_configBox);
    _logs = await Hive.openBox<DailyLog>(_logsBox);
    _prefs = await Hive.openBox(_userPrefsBox); // Dynamic box
  }

  // Typed boxes
  static Box<HabitConfig> get configBox => _config;
  static Box<DailyLog> get logsBox => _logs;

  // Dynamic box for flexible data (workouts list, genres, etc.)
  static Box get prefsBox => _prefs;

  // Convenience methods
  static Future<void> saveSelectedWorkouts(List<WorkoutModel> workouts) async {
    await _prefs.put(
      'selected_workouts_detailed',
      workouts.map((w) => w.toJson()).toList(),
    );
  }

  static List<WorkoutModel> getSelectedWorkouts() {
    final raw = _prefs.get('selected_workouts_detailed');
    if (raw == null) return [];

    return (raw as List)
        .cast<Map<String, dynamic>>()
        .map((json) => WorkoutModel.fromJson(json))
        .toList();
  }

  static Future<void> saveMusicGenres(List<String> genres) async {
    await _prefs.put('music_genres', genres);
  }

  static List<String> getMusicGenres() {
    return List<String>.from(_prefs.get('music_genres', defaultValue: <String>[]));
  }
}