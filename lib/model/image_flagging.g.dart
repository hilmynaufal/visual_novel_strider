// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_flagging.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageFlaggingAdapter extends TypeAdapter<ImageFlagging> {
  @override
  final int typeId = 3;

  @override
  ImageFlagging read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageFlagging(
      votecount: fields[0] as dynamic,
      sexualAvg: fields[1] as dynamic,
      violenceAvg: fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, ImageFlagging obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.votecount)
      ..writeByte(1)
      ..write(obj.sexualAvg)
      ..writeByte(2)
      ..write(obj.violenceAvg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageFlaggingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
