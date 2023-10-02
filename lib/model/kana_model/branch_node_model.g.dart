// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_node_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BranchNodeModelAdapter extends TypeAdapter<BranchNodeModel> {
  @override
  final int typeId = 13;

  @override
  BranchNodeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BranchNodeModel(
      id: fields[1] as String,
      createdAt: fields[3] as String,
      choiceSelectedId: fields[6] as String?,
      hasSelected: fields[5] as bool,
      vnid: fields[2] as String,
      choices: (fields[7] as List).cast<ChoiceModel>(),
      nodeType: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BranchNodeModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.vnid)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.nodeType)
      ..writeByte(5)
      ..write(obj.hasSelected)
      ..writeByte(6)
      ..write(obj.choiceSelectedId)
      ..writeByte(7)
      ..write(obj.choices);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BranchNodeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
