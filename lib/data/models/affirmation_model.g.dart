// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'affirmation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AffirmationModelAdapter extends TypeAdapter<AffirmationModel> {
  @override
  final int typeId = 0;

  @override
  AffirmationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AffirmationModel(
      text: fields[0] as String,
      date: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AffirmationModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AffirmationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
