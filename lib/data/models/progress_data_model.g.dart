// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProgressDataModelAdapter extends TypeAdapter<ProgressDataModel> {
  @override
  final int typeId = 3;

  @override
  ProgressDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProgressDataModel(
      date: fields[0] as DateTime,
      content: fields[1] as String,
      type: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProgressDataModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
