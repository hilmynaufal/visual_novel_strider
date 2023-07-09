// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screenshot_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScreenshotAdapter extends TypeAdapter<Screenshot> {
  @override
  final int typeId = 4;

  @override
  Screenshot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Screenshot(
      url: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Screenshot obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScreenshotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
