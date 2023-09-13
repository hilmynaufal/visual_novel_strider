// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailResultAdapter extends TypeAdapter<DetailResult> {
  @override
  final int typeId = 0;

  @override
  DetailResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailResult(
      rating: fields[1] as double?,
      description: fields[2] as String?,
      popularity: fields[3] as double?,
      screenshots: (fields[4] as List?)?.cast<Screenshot>(),
      image: fields[5] as Image?,
      id: fields[6] as String,
      tags: (fields[7] as List).cast<TagResult>(),
      languages: (fields[8] as List?)?.cast<String>(),
      alttitle: fields[9] as dynamic,
      title: fields[10] as String,
      released: fields[11] as String?,
      votecount: fields[12] as int?,
      olang: fields[13] as String?,
      length: fields[14] as int?,
      developers: (fields[21] as List).cast<DeveloperModel>(),
    )
      ..characters = (fields[19] as List?)?.cast<IndividualResult>()
      ..isComplete = fields[20] as bool?;
  }

  @override
  void write(BinaryWriter writer, DetailResult obj) {
    writer
      ..writeByte(17)
      ..writeByte(1)
      ..write(obj.rating)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.popularity)
      ..writeByte(4)
      ..write(obj.screenshots)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.tags)
      ..writeByte(8)
      ..write(obj.languages)
      ..writeByte(9)
      ..write(obj.alttitle)
      ..writeByte(10)
      ..write(obj.title)
      ..writeByte(11)
      ..write(obj.released)
      ..writeByte(12)
      ..write(obj.votecount)
      ..writeByte(13)
      ..write(obj.olang)
      ..writeByte(14)
      ..write(obj.length)
      ..writeByte(19)
      ..write(obj.characters)
      ..writeByte(20)
      ..write(obj.isComplete)
      ..writeByte(21)
      ..write(obj.developers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
