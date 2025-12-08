import 'package:daily_rise/service/hive_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatsProvider extends ChangeNotifier {
  List<String> statTab = ["weekly", "monthly", "all time"];
  String _selectedTab = "weekly";
  String get selectedTab => _selectedTab;
  set selectedTab(String value) {
    _selectedTab = value;
    notifyListeners();
  }

  String _selectedHabitFilter = "all";
  String get selectedHabitFilter => _selectedHabitFilter;
  set selectedHabitFilter(String value) {
    _selectedHabitFilter = value;
    notifyListeners();
  }

  List<String> get habitFilters => ["all", "reading", "water", "workout"];
  List<String> get statTabs => ["weekly", "monthly", "all time"];

  // Total lifetime for current filter
  int get lifetimeTotal {
    int total = 0;
    for (var log in HiveService.logsBox.values) {
      final value = log.completed[_selectedHabitFilter] ?? 0;
      total += _selectedHabitFilter == "all" ? value : value;
    }
    return total;
  }

  String get unit => switch (_selectedHabitFilter) {
    "reading" => "pages read",
    "water" => "glasses drank",
    "workout" => "reps completed",
    _ => "total actions",
  };

  // Weekly / Monthly data for chart
  List<FlSpot> getChartData() {
    final now = DateTime.now();
    final days = _selectedTab == "weekly" ? 7 : 30;
    final cutoff = now.subtract(Duration(days: days));

    final Map<int, double> data = {};

    for (int i = 0; i < days; i++) {
      final date = now.subtract(Duration(days: days - i - 1));
      final key = DateFormat('yyyy-MM-dd').format(date);
      final log = HiveService.logsBox.get(key);

      int value = 0;
      if (log != null) {
        if (_selectedHabitFilter == "all") {
          value = log.completed.values.fold(0, (a, b) => a + b);
        } else {
          value = log.completed[_selectedHabitFilter] ?? 0;
        }
      }
      data[i] = value.toDouble();
    }

    return data.entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList();
  }

  int get currentPeriodTotal {
    final spots = getChartData();
    return spots.fold(0, (sum, spot) => sum + spot.y.toInt());
  }

  int get previousPeriodTotal {
    final previous = _selectedTab == "weekly"
        ? getChartData().skip(7).take(7)
        : getChartData().skip(30).take(30);
    return previous.fold(0, (sum, spot) => sum + spot.y.toInt());
  }

  double get percentageChange {
    if (previousPeriodTotal == 0) return 100;
    return ((currentPeriodTotal - previousPeriodTotal) / previousPeriodTotal) *
        100;
  }
}
