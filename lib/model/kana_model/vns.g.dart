// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vns.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VnsAdapter extends TypeAdapter<Vns> {
  @override
  final int typeId = 6;

  @override
  Vns read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vns(
      id: fields[1] as String?,
      spoiler: fields[2] as int?,
      role: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Vns obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.spoiler)
      ..writeByte(3)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VnsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
