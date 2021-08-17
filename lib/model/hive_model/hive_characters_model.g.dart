// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_characters_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCHaractersModelAdapter extends TypeAdapter<HiveCHaractersModel> {
  @override
  final int typeId = 1;

  @override
  HiveCHaractersModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCHaractersModel(
      id: fields[0] as int,
      spoilGender: fields[2] as dynamic,
      gender: fields[3] as String?,
      original: fields[4] as String?,
      name: fields[1] as String?,
      bloodt: fields[5] as String?,
      birthday: (fields[6] as List?)?.cast<dynamic>(),
      imageFlagging: fields[11] as ImageFlagging?,
      image: fields[10] as String?,
      aliases: fields[7] as String?,
      description: fields[8] as String?,
      age: fields[9] as int?,
      vns: (fields[12] as List)
          .map((dynamic e) => (e as List).cast<dynamic>())
          .toList(),
      traits: (fields[13] as List)
          .map((dynamic e) => (e as List).cast<dynamic>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveCHaractersModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.spoilGender)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.original)
      ..writeByte(5)
      ..write(obj.bloodt)
      ..writeByte(6)
      ..write(obj.birthday)
      ..writeByte(7)
      ..write(obj.aliases)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.age)
      ..writeByte(10)
      ..write(obj.image)
      ..writeByte(11)
      ..write(obj.imageFlagging)
      ..writeByte(12)
      ..write(obj.vns)
      ..writeByte(13)
      ..write(obj.traits);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCHaractersModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
