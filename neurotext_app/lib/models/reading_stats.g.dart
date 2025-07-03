// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReadingStatsAdapter extends TypeAdapter<ReadingStats> {
  @override
  final int typeId = 2;

  @override
  ReadingStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReadingStats(
      date: fields[0] as String,
      readingTimeMinutes: fields[1] as int,
      wordsRead: fields[2] as int,
      articlesRead: fields[3] as int,
      sessionStart: fields[4] as DateTime,
      sessionEnd: fields[5] as DateTime,
      chaptersRead: fields[6] as int,
      novelsCompleted: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ReadingStats obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.readingTimeMinutes)
      ..writeByte(2)
      ..write(obj.wordsRead)
      ..writeByte(3)
      ..write(obj.articlesRead)
      ..writeByte(4)
      ..write(obj.sessionStart)
      ..writeByte(5)
      ..write(obj.sessionEnd)
      ..writeByte(6)
      ..write(obj.chaptersRead)
      ..writeByte(7)
      ..write(obj.novelsCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadingStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
