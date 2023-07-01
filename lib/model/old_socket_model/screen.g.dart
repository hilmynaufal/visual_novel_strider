// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScreenAdapter extends TypeAdapter<Screen> {
  @override
  final int typeId = 4;

  @override
  Screen read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Screen(
      image: fields[0] as String?,
      rid: fields[1] as int?,
      nsfw: fields[2] as bool?,
      flagging: fields[3] as ImageFlagging?,
      height: fields[4] as int?,
      width: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Screen obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.rid)
      ..writeByte(2)
      ..write(obj.nsfw)
      ..writeByte(3)
      ..write(obj.flagging)
      ..writeByte(4)
      ..write(obj.height)
      ..writeByte(5)
      ..write(obj.width);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScreenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
