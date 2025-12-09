import 'package:flutter/material.dart';

class WorkoutModel {
  final String workout;
  final bool isReps;
  final int duration; // reps or seconds
  final IconData icon;

  WorkoutModel({
    required this.workout,
    required this.isReps,
    required this.duration,
    required this.icon,
  });

  // Convert object → JSON (Map)
  Map<String, dynamic> toJson() => {
    'workout': workout,
    'isReps': isReps,
    'duration': duration,
    'iconCodePoint': icon.codePoint,
    'iconFontFamily': icon.fontFamily,
    'iconFontPackage': icon.fontPackage,
  };

  // Convert JSON (Map) → object
  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      workout: json['workout'] as String,
      isReps: json['isReps'] as bool,
      duration: json['duration'] as int,
      icon: IconData(
        json['iconCodePoint'] as int,
        fontFamily: json['iconFontFamily'] as String?,
        fontPackage: json['iconFontPackage'] as String?,
      ),
    );
  }

  // Optional: copyWith for easy updates
  WorkoutModel copyWith({
    String? workout,
    bool? isReps,
    int? duration,
    IconData? icon,
  }) {
    return WorkoutModel(
      workout: workout ?? this.workout,
      isReps: isReps ?? this.isReps,
      duration: duration ?? this.duration,
      icon: icon ?? this.icon,
    );
  }

  @override
  String toString() {
    return 'WorkoutModel(workout: $workout, isReps: $isReps, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WorkoutModel &&
        other.workout == workout &&
        other.isReps == isReps &&
        other.duration == duration &&
        other.icon.codePoint == icon.codePoint;
  }

  @override
  int get hashCode {
    return Object.hash(workout, isReps, duration, icon.codePoint);
  }
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
