// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockAdapter extends TypeAdapter<Stock> {
  @override
  final int typeId = 0;

  @override
  Stock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stock(
      name: fields[0] as String,
      cmp: fields[1] as double,
      yearHigh: fields[2] as double,
      yearLow: fields[3] as double,
      diiParticipation: fields[4] as double,
      fiiParticipation: fields[5] as double,
      notes: fields[6] as String,
      dateTime: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Stock obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.cmp)
      ..writeByte(2)
      ..write(obj.yearHigh)
      ..writeByte(3)
      ..write(obj.yearLow)
      ..writeByte(4)
      ..write(obj.diiParticipation)
      ..writeByte(5)
      ..write(obj.fiiParticipation)
      ..writeByte(6)
      ..write(obj.notes)
      ..writeByte(7)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
