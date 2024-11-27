// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspiration_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InspirationModelAdapter extends TypeAdapter<InspirationModel> {
  @override
  final int typeId = 4;

  @override
  InspirationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InspirationModel(
      text: fields[0] as String,
      date: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, InspirationModel obj) {
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
      other is InspirationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
