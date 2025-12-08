import 'package:hive_ce_flutter/hive_flutter.dart';
import '../data/models/habit_config.dart';
import '../data/models/daily_log.dart';

class HiveService {
  static const String _configBox = 'config_box';
  static const String _logsBox = 'logs_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HabitConfigAdapter());
    Hive.registerAdapter(DailyLogAdapter());
    await Hive.openBox<HabitConfig>(_configBox);
    await Hive.openBox<DailyLog>(_logsBox);
  }

  static Box<HabitConfig> get configBox => Hive.box<HabitConfig>(_configBox);
  static Box<DailyLog> get logsBox => Hive.box<DailyLog>(_logsBox);
}