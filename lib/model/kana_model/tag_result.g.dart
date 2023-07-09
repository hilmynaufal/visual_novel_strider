// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TagResultAdapter extends TypeAdapter<TagResult> {
  @override
  final int typeId = 5;

  @override
  TagResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TagResult(
      spoiler: fields[1] as int,
      rating: fields[2] as double,
      name: fields[3] as String,
      id: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TagResult obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.spoiler)
      ..writeByte(2)
      ..write(obj.rating)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TagResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
