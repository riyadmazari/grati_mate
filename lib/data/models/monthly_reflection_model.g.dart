// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_reflection_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthlyReflectionModelAdapter
    extends TypeAdapter<MonthlyReflectionModel> {
  @override
  final int typeId = 2;

  @override
  MonthlyReflectionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MonthlyReflectionModel(
      wins: fields[0] as String,
      improvements: fields[1] as String,
      inspiration: fields[2] as String,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MonthlyReflectionModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.wins)
      ..writeByte(1)
      ..write(obj.improvements)
      ..writeByte(2)
      ..write(obj.inspiration)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlyReflectionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
