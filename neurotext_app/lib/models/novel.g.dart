// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NovelAdapter extends TypeAdapter<Novel> {
  @override
  final int typeId = 1;

  @override
  Novel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Novel(
      id: fields[0] as String,
      title: fields[1] as String,
      chapters: (fields[2] as List).cast<NovelChapter>(),
      createdAt: fields[3] as DateTime,
      currentChapterIndex: fields[4] as int,
      coverImagePath: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Novel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.chapters)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.currentChapterIndex)
      ..writeByte(5)
      ..write(obj.coverImagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NovelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NovelChapterAdapter extends TypeAdapter<NovelChapter> {
  @override
  final int typeId = 4;

  @override
  NovelChapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NovelChapter(
      id: fields[0] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      chapterNumber: fields[3] as int,
      isRead: fields[4] as bool,
      readAt: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, NovelChapter obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.chapterNumber)
      ..writeByte(4)
      ..write(obj.isRead)
      ..writeByte(5)
      ..write(obj.readAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NovelChapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
