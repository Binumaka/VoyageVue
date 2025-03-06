// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DestinationHiveModelAdapter extends TypeAdapter<DestinationHiveModel> {
  @override
  final int typeId = 1;

  @override
  DestinationHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DestinationHiveModel(
      id: fields[0] as String?,
      title: fields[1] as String,
      category: fields[2] as String,
      image: fields[3] as String,
      image1: fields[4] as String,
      image2: fields[5] as String,
      bestTimeToVisit: fields[6] as String,
      location: fields[7] as String,
      description: fields[8] as String,
      section: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DestinationHiveModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.image1)
      ..writeByte(5)
      ..write(obj.image2)
      ..writeByte(6)
      ..write(obj.bestTimeToVisit)
      ..writeByte(7)
      ..write(obj.location)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.section);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DestinationHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
