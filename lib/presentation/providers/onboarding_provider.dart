import 'package:flutter/material.dart';
import 'package:daily_rise/data/models/onboarding.dart';
import 'package:daily_rise/gen/assets.gen.dart';

class OnboardingProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  List<OnboardingModel> onboardingItems = [
    OnboardingModel(
      image: Assets.icons.google.path,
      title: "Welcome to DailyRise",
      subtitle:
          'Build consistent habits for reading, working out, and staying hydrated.',
    ),
    OnboardingModel(
      image: Assets.icons.google.path,
      title: "Rise Early",
      subtitle: 'Rise every day.\nRead. Move. Reflect.',
    ),
    OnboardingModel(
      image: Assets.icons.google.path,
      title: "Never Miss A Day",
      subtitle: "We'll help you with daily reminders and progress tracking.",
    ),
  ];
}
