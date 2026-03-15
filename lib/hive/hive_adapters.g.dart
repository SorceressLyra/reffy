// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class ReferenceImageAdapter extends TypeAdapter<ReferenceImage> {
  @override
  final typeId = 0;

  @override
  ReferenceImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReferenceImage(
      imagePath: fields[0] as Directory,
      albums: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ReferenceImage obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.imagePath)
      ..writeByte(1)
      ..write(obj.albums);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReferenceImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DirectoryAdapter extends TypeAdapter<Directory> {
  @override
  final typeId = 1;

  @override
  Directory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Directory(fields[0] as String);
  }

  @override
  void write(BinaryWriter writer, Directory obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DirectoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
