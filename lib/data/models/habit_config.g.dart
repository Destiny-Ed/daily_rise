// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitConfigAdapter extends TypeAdapter<HabitConfig> {
  @override
  final typeId = 0;

  @override
  HabitConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitConfig(
      id: fields[0] as String,
      name: fields[1] as String,
      isActive: fields[2] as bool,
      target: (fields[3] as num).toInt(),
      bookTitle: fields[4] as String?,
      workoutType: fields[5] as String?,
      musicGenres: fields[6] == null
          ? const []
          : (fields[6] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, HabitConfig obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.isActive)
      ..writeByte(3)
      ..write(obj.target)
      ..writeByte(4)
      ..write(obj.bookTitle)
      ..writeByte(5)
      ..write(obj.workoutType)
      ..writeByte(6)
      ..write(obj.musicGenres);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
