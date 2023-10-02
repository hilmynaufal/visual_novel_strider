// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventNodeModelAdapter extends TypeAdapter<EventNodeModel> {
  @override
  final int typeId = 10;

  @override
  EventNodeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventNodeModel(
      id: fields[0] as String,
      character: fields[2] as IndividualResult?,
      playtime: fields[4] as String,
      lastPlayed: fields[5] as DateTime,
      hexColor: fields[6] as int,
      isCompleted: fields[7] as bool,
      endTime: fields[10] as String,
      isPlaying: fields[8] as bool,
      vnId: fields[1] as String,
      createdAt: fields[12] as DateTime,
      note: fields[11] as String,
      nodeType: fields[15] as String,
      nextNodeId: fields[14] as String?,
      previousNodeId: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EventNodeModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(13)
      ..write(obj.previousNodeId)
      ..writeByte(14)
      ..write(obj.nextNodeId)
      ..writeByte(15)
      ..write(obj.nodeType)
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
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventNodeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
