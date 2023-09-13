// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NodeModelAdapter extends TypeAdapter<NodeModel> {
  @override
  final int typeId = 10;

  @override
  NodeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NodeModel(
      id: fields[0] as String,
      character: fields[2] as IndividualResult?,
      playtime: fields[4] as String,
      lastPlayed: fields[5] as DateTime,
      hexColor: fields[6] as int,
      isCompleted: fields[7] as bool,
      endTime: fields[10] as String,
      isPlaying: fields[8] as bool,
      vnId: fields[1] as String,
      note: fields[11] as String,
      nextNodeId: fields[13] as String?,
      previousNodeId: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NodeModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(12)
      ..write(obj.previousNodeId)
      ..writeByte(13)
      ..write(obj.nextNodeId)
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
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NodeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
