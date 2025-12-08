class UserProgress {
  final int streak;
  final DateTime lastCompletedDate;
  final Map<String, bool> todayCompleted; // habitId -> completed

  UserProgress({
    required this.streak,
    required this.lastCompletedDate,
    required this.todayCompleted,
  });

  factory UserProgress.empty() => UserProgress(
        streak: 0,
        lastCompletedDate: DateTime.now().subtract(const Duration(days: 1)),
        todayCompleted: {},
      );

  UserProgress copyWith({
    int? streak,
    DateTime? lastCompletedDate,
    Map<String, bool>? todayCompleted,
  }) {
    return UserProgress(
      streak: streak ?? this.streak,
      lastCompletedDate: lastCompletedDate ?? this.lastCompletedDate,
      todayCompleted: todayCompleted ?? this.todayCompleted,
    );
  }
}