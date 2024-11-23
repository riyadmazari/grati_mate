// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompt_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PromptModelAdapter extends TypeAdapter<PromptModel> {
  @override
  final int typeId = 2;

  @override
  PromptModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PromptModel(
      text: fields[0] as String,
      isPinned: fields[1] as bool,
      date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PromptModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.isPinned)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PromptModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
