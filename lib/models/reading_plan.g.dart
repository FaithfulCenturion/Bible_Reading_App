// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_plan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReadingPlanAdapter extends TypeAdapter<ReadingPlan> {
  @override
  final int typeId = 0;

  @override
  ReadingPlan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReadingPlan()
      ..plannedStartDate = fields[0] as DateTime
      ..plannedEndDate = fields[1] as DateTime
      ..includeOldTestament = fields[2] as bool
      ..includeApocrypha = fields[3] as bool
      ..includeNewTestament = fields[4] as bool
      ..dailyReadings = (fields[5] as List).cast<DailyReading>();
  }

  @override
  void write(BinaryWriter writer, ReadingPlan obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.plannedStartDate)
      ..writeByte(1)
      ..write(obj.plannedEndDate)
      ..writeByte(2)
      ..write(obj.includeOldTestament)
      ..writeByte(3)
      ..write(obj.includeApocrypha)
      ..writeByte(4)
      ..write(obj.includeNewTestament)
      ..writeByte(5)
      ..write(obj.dailyReadings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadingPlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DailyReadingAdapter extends TypeAdapter<DailyReading> {
  @override
  final int typeId = 1;

  @override
  DailyReading read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyReading()
      ..date = fields[0] as DateTime
      ..passage = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, DailyReading obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.passage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyReadingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
