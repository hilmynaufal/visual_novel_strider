// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'links.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LinksAdapter extends TypeAdapter<Links> {
  @override
  final int typeId = 2;

  @override
  Links read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Links(
      encubed: fields[0] as dynamic,
      renai: fields[1] as dynamic,
      wikipedia: fields[2] as String?,
      wikidata: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Links obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.encubed)
      ..writeByte(1)
      ..write(obj.renai)
      ..writeByte(2)
      ..write(obj.wikipedia)
      ..writeByte(3)
      ..write(obj.wikidata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LinksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
