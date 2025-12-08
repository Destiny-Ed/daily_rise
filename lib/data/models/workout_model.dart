import 'package:flutter/material.dart';

class WorkoutModel {
  final String workout;
  final bool isReps;
  final int duration;
  final IconData icon;

  WorkoutModel({
    required this.workout,
    required this.isReps,
    required this.duration,
    required this.icon,
  });
}

class AppModel {
  final String appName;
  final String icon;
  final String packageName;

  AppModel({
    required this.appName,
    required this.icon,
    required this.packageName,
  });
}
 