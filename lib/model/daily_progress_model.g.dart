// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_progress_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyProgressModelAdapter extends TypeAdapter<DailyProgressModel> {
  @override
  final int typeId = 0;

  @override
  DailyProgressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyProgressModel(
      progressDateTime: fields[0] as DateTime?,
      totalCount: fields[1] as int,
      cardboardCount: fields[2] as int,
      glassCount: fields[3] as int,
      metalCount: fields[4] as int,
      paperCount: fields[5] as int,
      plasticCount: fields[6] as int,
      trash: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DailyProgressModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.progressDateTime)
      ..writeByte(1)
      ..write(obj.totalCount)
      ..writeByte(2)
      ..write(obj.cardboardCount)
      ..writeByte(3)
      ..write(obj.glassCount)
      ..writeByte(4)
      ..write(obj.metalCount)
      ..writeByte(5)
      ..write(obj.paperCount)
      ..writeByte(6)
      ..write(obj.plasticCount)
      ..writeByte(7)
      ..write(obj.trash);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyProgressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
