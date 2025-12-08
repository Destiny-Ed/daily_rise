enum HabitType { reading, workout, drinkingwater }

class Habit {
  final String id;
  final HabitType type;
  final String title;
  final int target; // pages or reps
  final String? playlistUrl;

  Habit({
    required this.id,
    required this.type,
    required this.title,
    required this.target,
    this.playlistUrl,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.index,
        'title': title,
        'target': target,
        'playlistUrl': playlistUrl,
      };

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
        id: json['id'],
        type: HabitType.values[json['type']],
        title: json['title'],
        target: json['target'],
        playlistUrl: json['playlistUrl'],
      );
}