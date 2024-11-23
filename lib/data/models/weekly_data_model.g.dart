// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeeklyDataModelAdapter extends TypeAdapter<WeeklyDataModel> {
  @override
  final int typeId = 2;

  @override
  WeeklyDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeeklyDataModel(
      focus: fields[0] as String,
      reflection: fields[1] as String,
      favorite: fields[2] as String,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, WeeklyDataModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.focus)
      ..writeByte(1)
      ..write(obj.reflection)
      ..writeByte(2)
      ..write(obj.favorite)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeeklyDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
