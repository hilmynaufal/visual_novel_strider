// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveVNModelAdapter extends TypeAdapter<HiveVNModel> {
  @override
  final int typeId = 0;

  @override
  HiveVNModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveVNModel(
      id: fields[0] as int,
      aliases: fields[2] as String?,
      popularity: fields[3] as double?,
      imageNsfw: fields[4] as bool?,
      links: fields[5] as Links?,
      rating: fields[6] as double?,
      platforms: (fields[7] as List?)?.cast<String>(),
      original: fields[8] as dynamic,
      tags: (fields[9] as List?)
          ?.map((dynamic e) => (e as List).cast<double>())
          .toList(),
      description: fields[10] as String?,
      votecount: fields[11] as int?,
      title: fields[1] as String?,
      origLang: (fields[12] as List?)?.cast<String>(),
      released: fields[13] as String?,
      languages: (fields[14] as List?)?.cast<String>(),
      imageFlagging: fields[15] as ImageFlagging?,
      image: fields[16] as String?,
      length: fields[17] as int?,
      screens: (fields[18] as List?)?.cast<Screen>(),
    )..characters = (fields[19] as List?)?.cast<HiveCHaractersModel>();
  }

  @override
  void write(BinaryWriter writer, HiveVNModel obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.aliases)
      ..writeByte(3)
      ..write(obj.popularity)
      ..writeByte(4)
      ..write(obj.imageNsfw)
      ..writeByte(5)
      ..write(obj.links)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.platforms)
      ..writeByte(8)
      ..write(obj.original)
      ..writeByte(9)
      ..write(obj.tags)
      ..writeByte(10)
      ..write(obj.description)
      ..writeByte(11)
      ..write(obj.votecount)
      ..writeByte(12)
      ..write(obj.origLang)
      ..writeByte(13)
      ..write(obj.released)
      ..writeByte(14)
      ..write(obj.languages)
      ..writeByte(15)
      ..write(obj.imageFlagging)
      ..writeByte(16)
      ..write(obj.image)
      ..writeByte(17)
      ..write(obj.length)
      ..writeByte(18)
      ..write(obj.screens)
      ..writeByte(19)
      ..write(obj.characters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveVNModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
