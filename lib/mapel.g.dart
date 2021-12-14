// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MapelAdapter extends TypeAdapter<Mapel> {
  @override
  final int typeId = 1;

  @override
  Mapel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Mapel()
      ..title = fields[0] as String
      ..kelas = fields[1] as String
      ..jam = fields[2] as dynamic;
  }

  @override
  void write(BinaryWriter writer, Mapel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.kelas)
      ..writeByte(2)
      ..write(obj.jam);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
