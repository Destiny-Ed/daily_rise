// import 'package:flutter/material.dart';
// import 'package:daily_rise/data/models/workout_model.dart';
// import 'package:icons_plus/icons_plus.dart';

// class AppsOnboardingProvider extends ChangeNotifier {
//   int _currentIndex = 1;
//   int get currentIndex => _currentIndex;

//   set currentIndex(int value) {
//     _currentIndex = value;
//     notifyListeners();
//   }

//   int maxIndex = 3;

//   // ExerciseAppModel? _selectedExerciseAppWorkout;
//   // ExerciseAppModel? get selectedExerciseAppWorkout =>
//   //     _selectedExerciseAppWorkout;

//   // set selectedExerciseAppWorkout(ExerciseAppModel appData) {
//   //   _selectedExerciseAppWorkout = appData;
//   //   notifyListeners();
//   // }

// List<String> musicGenres = [
//   "pop",
//   "hip hop / rap",
//   "rock",
//   "electronic / EDM",
//   "latin",
//   "R&B",
//   "indie",
//   "gospel",
//   "classical / instrumental",
// ];

//   WorkoutModel? _selectedWorkout;
//   WorkoutModel? get selectedWorkout => _selectedWorkout;

//   set selectedWorkout(WorkoutModel? workout) {
//     _selectedWorkout = workout;
//     notifyListeners();
//   }

//   List<WorkoutModel> workouts = [
//     WorkoutModel(
//       duration: 20,
//       workout: "push-ups",
//       isReps: true,
//       icon: PixelArtIcons.human,
//     ),
//     WorkoutModel(
//       duration: 20,
//       workout: "sit-ups",
//       isReps: true,
//       icon: PixelArtIcons.human,
//     ),
//     WorkoutModel(
//       duration: 20,
//       workout: "squats",
//       isReps: true,
//       icon: PixelArtIcons.human,
//     ),
//     WorkoutModel(
//       duration: 20,
//       workout: "jumping jacks",
//       isReps: false,
//       icon: PixelArtIcons.human,
//     ),
//   ];
//   final List<String> _selectedGenres = [];
//   List<String> get selectedGenres => _selectedGenres;

//   set selectedGenres(String value) {
//     final lwValue = value.toLowerCase();
//     if (_selectedGenres.contains(lwValue)) {
//       _selectedGenres.remove(lwValue);
//     } else {
//       _selectedGenres.add(lwValue);
//     }
//     notifyListeners();
//   }
// }

import 'package:daily_rise/data/models/daily_log.dart';
import 'package:daily_rise/data/models/workout_model.dart';
import 'package:daily_rise/service/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:daily_rise/data/models/habit_config.dart';

class AppsOnboardingProvider extends ChangeNotifier {
  List<String> musicGenres = [
    "pop",
    "hip hop / rap",
    "rock",
    "electronic / EDM",
    "latin",
    "R&B",
    "indie",
    "gospel",
    "classical / instrumental",
  ];

  int _currentIndex = 1;
  int get currentIndex => _currentIndex;
  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  final maxIndex = 3;

  // Step 1
  String bookTitle = "";
  int waterGlasses = 8;

  // Step 2 - MULTIPLE WORKOUTS
  final Map<int, bool> _selectedWorkouts = {}; // index → selected
  final Map<int, int> _workoutReps = {}; // index → reps

  bool isWorkoutSelected(int index) => _selectedWorkouts[index] ?? false;
  int getWorkoutReps(int index) => _workoutReps[index] ?? 20;

  void toggleWorkout(int index) {
    _selectedWorkouts[index] = !(_selectedWorkouts[index] ?? false);
    if (!_selectedWorkouts[index]!) {
      _workoutReps.remove(index);
    } else {
      _workoutReps[index] = 20; // default
    }
    notifyListeners();
  }

  void updateReps(int index, int reps) {
    if (_selectedWorkouts[index] == true) {
      _workoutReps[index] = reps.clamp(5, 200);
      notifyListeners();
    }
  }

  List<WorkoutModel> get selectedWorkoutsList {
    return _selectedWorkouts.entries
        .where((e) => e.value)
        .map(
          (e) => WorkoutModel(
            workout: workouts[e.key].workout,
            duration: getWorkoutReps(e.key),
            isReps: true,
            icon: workouts[e.key].icon,
          ),
        )
        .toList();
  }

  // Step 3
  final List<String> _selectedGenres = [];
  List<String> get selectedGenres => _selectedGenres;
  void toggleGenre(String genre) {
    final lower = genre.toLowerCase();
    if (_selectedGenres.contains(lower)) {
      _selectedGenres.remove(lower);
    } else {
      _selectedGenres.add(lower);
    }
    notifyListeners();
  }

  List<WorkoutModel> workouts = [
    WorkoutModel(
      duration: 20,
      workout: "push-ups",
      isReps: true,
      icon: Icons.fitness_center,
    ),
    WorkoutModel(
      duration: 20,
      workout: "sit-ups",
      isReps: true,
      icon: Icons.accessibility_new,
    ),
    WorkoutModel(
      duration: 20,
      workout: "squats",
      isReps: true,
      icon: Icons.airline_seat_legroom_extra,
    ),
    WorkoutModel(
      duration: 20,
      workout: "jumping jacks",
      isReps: true,
      icon: Icons.run_circle,
    ),
    WorkoutModel(
      duration: 30,
      workout: "plank",
      isReps: false,
      icon: Icons.timelapse,
    ),
  ];

  // Save all
  Future<void> saveHabits() async {
    final box = HiveService.configBox;
    final box2 = HiveService.prefsBox;

    final habits = [
      HabitConfig(
        id: "reading",
        name: "Reading",
        isActive: true,
        target: 20,
        bookTitle: bookTitle.isEmpty ? "Your Book" : bookTitle,
      ),
      HabitConfig(
        id: "water",
        name: "Drink Water",
        isActive: true,
        target: waterGlasses,
      ),
      HabitConfig(
        id: "workout",
        name: "Workout",
        isActive: selectedWorkoutsList.isNotEmpty,
        target: selectedWorkoutsList
            .map((w) => w.duration)
            .fold(0, (a, b) => a + b),
        workoutType: selectedWorkoutsList.map((w) => w.workout).join(", "),
        musicGenres: _selectedGenres,
      ),
    ];

    await box.clear();
    for (var habit in habits) {
      await box.put(habit.id, habit);
    }

    // Save detailed workouts
    await box2.put(
      "selected_workouts_detailed",
      selectedWorkoutsList.map((w) => w.toJson()).toList(),
    );

    await _initializeTodayLog();
    notifyListeners();
  }

  Future<void> _initializeTodayLog() async {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    if (HiveService.logsBox.containsKey(today)) return;
    await HiveService.logsBox.put(
      today,
      DailyLog.today(completed: {}, streak: 1),
    );
  }
}
