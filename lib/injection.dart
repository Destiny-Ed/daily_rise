import 'package:daily_rise/presentation/providers/apps_onboarding_provider.dart';
import 'package:daily_rise/presentation/providers/habit_provider.dart';
import 'package:daily_rise/presentation/providers/main_activity_provider.dart';
import 'package:daily_rise/presentation/providers/onboarding_provider.dart';
import 'package:daily_rise/presentation/providers/stats_provider.dart';
import 'package:daily_rise/presentation/providers/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers(BuildContext context) => [
  ChangeNotifierProvider(create: (context) => OnboardingProvider()),
  ChangeNotifierProvider(create: (context) => AppsOnboardingProvider()),
  ChangeNotifierProvider(create: (context) => MainActivityProvider()),
  ChangeNotifierProvider(create: (context) => StatsProvider()),
  ChangeNotifierProvider(create: (context) => WorkoutProvider()..init()),
  ChangeNotifierProvider(create: (context) => HabitProvider()..init()),
];
