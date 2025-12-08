import 'package:daily_rise/presentation/widgets/form_field.dart';
import 'package:daily_rise/presentation/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_rise/core/extensions.dart';
import 'package:daily_rise/core/theme.dart';
import 'package:daily_rise/presentation/providers/apps_onboarding_provider.dart';
import 'package:daily_rise/presentation/views/main_activity.dart';

class ChooseOnBoardingHabits extends StatefulWidget {
  const ChooseOnBoardingHabits({super.key});

  @override
  State<ChooseOnBoardingHabits> createState() => _ChooseOnBoardingHabitsState();
}

class _ChooseOnBoardingHabitsState extends State<ChooseOnBoardingHabits> {
  final _pageController = PageController();
  final _bookController = TextEditingController();
  int _waterCount = 8;
  int? _selectedWorkoutIndex;
  int _workoutReps = 20;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppsOnboardingProvider>().currentIndex = 1;
    });
  }

  void _nextPage() {
    if (_pageController.page! < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }
  }

  bool _validateStep(int step) {
    final vm = context.read<AppsOnboardingProvider>();

    switch (step) {
      case 1:
        if (_bookController.text.trim().isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please enter a book title")),
          );
          return false;
        }
        if (_waterCount < 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Water count must be at least 1")),
          );
          return false;
        }
        // Save step 1
        vm.bookTitle = _bookController.text.trim();
        vm.waterGlasses = _waterCount;
        return true;

      case 2:
        if (_selectedWorkoutIndex == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please select a workout")),
          );
          return false;
        }
        if (_workoutReps < 5) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Minimum 5 reps")));
          return false;
        }
        // Save step 2
        vm.selectedWorkout = vm.workouts[_selectedWorkoutIndex!];
        vm.workoutTarget = _workoutReps;
        return true;

      case 3:
        if (vm.selectedGenres.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Pick at least one music genre")),
          );
          return false;
        }
        return true;

      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppsOnboardingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Step ${vm.currentIndex} of 3"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) => vm.currentIndex = value + 1,
                physics: const NeverScrollableScrollPhysics(), // Prevent swipe
                children: [
                  AppOnboardingStepOne(
                    bookController: _bookController,
                    waterCount: _waterCount,
                    onWaterChanged: (val) => setState(() => _waterCount = val),
                  ),
                  AppOnboardingStepTwo(
                    selectedIndex: _selectedWorkoutIndex,
                    onSelect: (index) =>
                        setState(() => _selectedWorkoutIndex = index),
                    reps: _workoutReps,
                    onRepsChanged: (val) => setState(() => _workoutReps = val),
                    vm: vm,
                  ),
                  AppOnboardingStepThree(vm: vm),
                ],
              ),
            ),

            20.height(),

            CustomButton(
              text: vm.currentIndex == 3 ? "Save & Continue" : "Continue",
              onTap: () async {
                final isValid = _validateStep(vm.currentIndex);
                if (!isValid) return;

                if (vm.currentIndex < 3) {
                  _nextPage();
                } else {
                  // Final save
                  await vm.saveHabits();
                  if (!mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MainActivity()),
                  );
                }
              },
            ),
            40.height(),
          ],
        ),
      ),
    );
  }
}

// Step 1: Reading + Water
class AppOnboardingStepOne extends StatelessWidget {
  final TextEditingController bookController;
  final int waterCount;
  final ValueChanged<int> onWaterChanged;

  const AppOnboardingStepOne({
    super.key,
    required this.bookController,
    required this.waterCount,
    required this.onWaterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        Text(
          "What will you conquer today?".cap,
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontSize: 30),
        ),
        Text(
          "Choose the habits you want to build. You can always change these later."
              .capitalize,
          style: Theme.of(context).textTheme.titleMedium,
        ),

        10.height(),

        Expanded(
          child: ListView(
            children: [
              // Reading
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).cardColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(Icons.book),
                      ),
                      title: Text(
                        "Reading",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      trailing: Switch(value: true, onChanged: (value) {}),
                    ),
                    Column(
                      children: [
                        Divider(color: AppColors.darkGray),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Select Book To Read".cap,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        8.height(),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CustomTextField(
                            bookController,
                            hint: "e.g. Atomic Habits",
                            password: false,
                            suffixIcon: Icon(
                              Icons.search,
                              color: Theme.of(
                                context,
                              ).textTheme.titleMedium!.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Water
              Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).cardColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(Icons.water_drop),
                      ),
                      title: Text(
                        "Drink Water",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      trailing: Switch(value: true, onChanged: (value) {}),
                    ),
                    Column(
                      children: [
                        Divider(color: AppColors.darkGray),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Number of times to drink water daily".cap,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),

                        Container(
                          height: 50,
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // border: Border.all(),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: 20,
                            children: [
                              counterButton(
                                context,
                                Icons.remove,
                                () => onWaterChanged(waterCount - 1),
                                waterCount > 1,
                              ),
                              Text(
                                "$waterCount",
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineLarge,
                              ),
                              counterButton(
                                context,
                                Icons.add,
                                () => onWaterChanged(waterCount + 1),
                                true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Step 2: Workout Selection
class AppOnboardingStepTwo extends StatelessWidget {
  final int? selectedIndex;
  final ValueChanged<int> onSelect;
  final int reps;
  final ValueChanged<int> onRepsChanged;
  final AppsOnboardingProvider vm;

  const AppOnboardingStepTwo({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
    required this.reps,
    required this.onRepsChanged,
    required this.vm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        Text(
          "Set your challenges".cap,
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontSize: 30),
        ),
        Text(
          "select the exercises you'd like to include in your daily routine and set your starting reps and durations."
              .capitalize,

          style: Theme.of(context).textTheme.titleMedium,
        ),

        10.height(),

        Expanded(
          child: ListView.builder(
            itemCount: vm.workouts.length,
            itemBuilder: (context, index) {
              final workout = vm.workouts[index];
              final isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () => onSelect(index),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: isSelected
                        ? Theme.of(context).primaryColor.withOpacity(0.2)
                        : Theme.of(context).cardColor,
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(workout.icon),
                        ),
                        title: Text(
                          workout.workout.cap,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        // trailing: Switch(value: true, onChanged: (value) {}),
                        trailing: Switch(
                          value: index == selectedIndex,
                          // groupValue: selectedIndex,
                          onChanged: (_) => onSelect(index),
                        ),
                      ),
                      if (isSelected) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(color: AppColors.darkGray),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: Row(
                                spacing: 5,
                                children: [
                                  Icon(
                                    getIconAndString(workout.isReps).icon,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.titleMedium!.color,
                                  ),
                                  Text(
                                    "choose default ${getIconAndString(workout.isReps).title}"
                                        .cap,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              margin: const EdgeInsets.all(10.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                // border: Border.all(),
                                color: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                              ),
                              child: Row(
                                spacing: 20,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  counterButton(
                                    context,
                                    Icons.remove,
                                    () => onRepsChanged(reps - 5),
                                    reps > 10,
                                  ),
                                  Text(
                                    "$reps",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineLarge,
                                  ),
                                  counterButton(
                                    context,
                                    Icons.add,
                                    () => onRepsChanged(reps + 5),
                                    true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  ({IconData icon, String title}) getIconAndString(bool isReps) {
    if (isReps) {
      return (icon: Icons.replay, title: "reps");
    } else {
      return (icon: Icons.alarm, title: "duration(sec)");
    }
  }
}

Widget counterButton(
  BuildContext context,
  IconData icon,
  VoidCallback onTap,
  bool enabled,
) {
  return GestureDetector(
    onTap: enabled ? onTap : null,
    child: CircleAvatar(
      radius: 24,
      backgroundColor: enabled ? Theme.of(context).primaryColor : Colors.grey,
      child: Icon(icon, color: Colors.white),
    ),
  );
}

// Step 3: Music Genres (Already perfect)
class AppOnboardingStepThree extends StatelessWidget {
  final AppsOnboardingProvider vm;
  const AppOnboardingStepThree({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        Text(
          "Tune your workout".cap,
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontSize: 30),
        ),
        Text(
          "pick your favorite music genres. We'll build playlists to keep you motivated."
              .capitalize,
          style: Theme.of(context).textTheme.titleMedium,
        ),

        10.height(),

        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: vm.musicGenres.length,
            itemBuilder: (context, index) {
              final genre = vm.musicGenres[index];
              final isSelected = vm.selectedGenres.contains(
                genre.toLowerCase(),
              );

              return GestureDetector(
                onTap: () => vm.toggleGenre(genre),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.only(right: 10, left: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor,
                    border: isSelected
                        ? Border.all(color: AppColors.primaryGreen)
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          genre.cap,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Checkbox(
                        shape: OvalBorder(),
                        value: isSelected,
                        onChanged: (_) => vm.toggleGenre(genre),
                        activeColor: AppColors.primaryGreen,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
