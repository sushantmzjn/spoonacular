// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calorie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TotalCalorieAdapter extends TypeAdapter<TotalCalorie> {
  @override
  final int typeId = 2;

  @override
  TotalCalorie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TotalCalorie(
      totalCalorie: fields[0] as int,
      dateTime: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TotalCalorie obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.totalCalorie)
      ..writeByte(1)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotalCalorieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
