// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChoiceModelAdapter extends TypeAdapter<ChoiceModel> {
  @override
  final int typeId = 14;

  @override
  ChoiceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChoiceModel(
      id: fields[1] as String,
      character: fields[2] as IndividualResult,
      choiceOrig: fields[3] as String,
      choiceTrans: fields[4] as String,
      isSelected: fields[5] as String,
      hexColor: fields[6] as int,
      nextNodeId: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ChoiceModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.character)
      ..writeByte(3)
      ..write(obj.choiceOrig)
      ..writeByte(4)
      ..write(obj.choiceTrans)
      ..writeByte(5)
      ..write(obj.isSelected)
      ..writeByte(6)
      ..write(obj.hexColor)
      ..writeByte(7)
      ..write(obj.nextNodeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChoiceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
