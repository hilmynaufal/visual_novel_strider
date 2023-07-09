// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trait.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TraitAdapter extends TypeAdapter<Trait> {
  @override
  final int typeId = 7;

  @override
  Trait read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trait(
      groupName: fields[0] as String,
      name: fields[1] as String,
      id: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Trait obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.groupName)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TraitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}