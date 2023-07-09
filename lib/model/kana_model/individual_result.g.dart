// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individual_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IndividualResultAdapter extends TypeAdapter<IndividualResult> {
  @override
  final int typeId = 1;

  @override
  IndividualResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IndividualResult(
      traits: (fields[1] as List).cast<Trait>(),
      id: fields[0] as String,
      sex: (fields[2] as List?)?.cast<String>(),
      vns: (fields[3] as List).cast<Vns>(),
      image: fields[4] as Image?,
      birthday: (fields[5] as List?)?.cast<int>(),
      name: fields[6] as String,
      description: fields[7] as String?,
      age: fields[8] as int?,
      original: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, IndividualResult obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.traits)
      ..writeByte(2)
      ..write(obj.sex)
      ..writeByte(3)
      ..write(obj.vns)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.birthday)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.age)
      ..writeByte(9)
      ..write(obj.original);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndividualResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
