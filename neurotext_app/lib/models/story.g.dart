// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoryAdapter extends TypeAdapter<Story> {
  @override
  final int typeId = 3;

  @override
  Story read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Story(
      id: fields[0] as String,
      title: fields[1] as String,
      author: fields[2] as String,
      content: fields[3] as String,
      category: fields[4] as String,
      wordCount: fields[5] as int,
      estimatedReadingTimeMinutes: fields[6] as int,
      createdAt: fields[7] as DateTime,
      isPreloaded: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Story obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.wordCount)
      ..writeByte(6)
      ..write(obj.estimatedReadingTimeMinutes)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.isPreloaded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
