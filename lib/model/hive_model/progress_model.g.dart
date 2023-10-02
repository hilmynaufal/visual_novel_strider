// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProgressModelAdapter extends TypeAdapter<ProgressModel> {
  @override
  final int typeId = 9;

  @override
  ProgressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProgressModel(
      id: fields[0] as String,
      character: fields[2] as IndividualResult?,
      reminder: fields[3] as String,
      playtime: fields[4] as String,
      lastPlayed: fields[5] as DateTime,
      hexColor: fields[6] as int,
      isCompleted: fields[7] as bool,
      endTime: fields[10] as String,
      hasReminder: fields[9] as bool,
      isPlaying: fields[8] as bool,
      vnId: fields[1] as String,
      createdAt: fields[12] as DateTime,
      note: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProgressModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.vnId)
      ..writeByte(2)
      ..write(obj.character)
      ..writeByte(4)
      ..write(obj.playtime)
      ..writeByte(5)
      ..write(obj.lastPlayed)
      ..writeByte(6)
      ..write(obj.hexColor)
      ..writeByte(7)
      ..write(obj.isCompleted)
      ..writeByte(8)
      ..write(obj.isPlaying)
      ..writeByte(10)
      ..write(obj.endTime)
      ..writeByte(11)
      ..write(obj.note)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.reminder)
      ..writeByte(9)
      ..write(obj.hasReminder);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
