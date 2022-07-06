// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 0;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      category: fields[1] as Categories,
      title: fields[2] as String,
      comment: fields[3] as String,
      rating: fields[4] as double,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.comment)
      ..writeByte(4)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoriesAdapter extends TypeAdapter<Categories> {
  @override
  final int typeId = 1;

  @override
  Categories read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Categories.series;
      case 1:
        return Categories.movies;
      case 2:
        return Categories.books;
      default:
        return Categories.series;
    }
  }

  @override
  void write(BinaryWriter writer, Categories obj) {
    switch (obj) {
      case Categories.series:
        writer.writeByte(0);
        break;
      case Categories.movies:
        writer.writeByte(1);
        break;
      case Categories.books:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SortModesAdapter extends TypeAdapter<SortModes> {
  @override
  final int typeId = 2;

  @override
  SortModes read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SortModes.date;
      case 1:
        return SortModes.alpha;
      case 2:
        return SortModes.rating;
      default:
        return SortModes.date;
    }
  }

  @override
  void write(BinaryWriter writer, SortModes obj) {
    switch (obj) {
      case SortModes.date:
        writer.writeByte(0);
        break;
      case SortModes.alpha:
        writer.writeByte(1);
        break;
      case SortModes.rating:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SortModesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
