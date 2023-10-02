// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playground_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaygroundModelAdapter extends TypeAdapter<PlaygroundModel> {
  @override
  final int typeId = 12;

  @override
  PlaygroundModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaygroundModel(
      id: fields[0] as String,
      vnId: fields[1] as String,
      eventNodes: (fields[7] as List).cast<EventNodeModel>(),
      name: fields[2] as String,
      createdAt: fields[3] as String,
      isFinished: fields[5] as bool,
      route: fields[6] as String,
      lastPlayed: fields[4] as String,
      branchNodes: (fields[8] as List).cast<BranchNodeModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlaygroundModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.vnId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.lastPlayed)
      ..writeByte(5)
      ..write(obj.isFinished)
      ..writeByte(6)
      ..write(obj.route)
      ..writeByte(7)
      ..write(obj.eventNodes)
      ..writeByte(8)
      ..write(obj.branchNodes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaygroundModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
