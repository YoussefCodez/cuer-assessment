// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingStatusAdapter extends TypeAdapter<BookingStatus> {
  @override
  final typeId = 5;

  @override
  BookingStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BookingStatus.pending;
      case 1:
        return BookingStatus.confirmed;
      case 2:
        return BookingStatus.completed;
      case 3:
        return BookingStatus.cancelled;
      default:
        return BookingStatus.pending;
    }
  }

  @override
  void write(BinaryWriter writer, BookingStatus obj) {
    switch (obj) {
      case BookingStatus.pending:
        writer.writeByte(0);
      case BookingStatus.confirmed:
        writer.writeByte(1);
      case BookingStatus.completed:
        writer.writeByte(2);
      case BookingStatus.cancelled:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
