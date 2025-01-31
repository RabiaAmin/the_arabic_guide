// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VocabularyAdapter extends TypeAdapter<Vocabulary> {
  @override
  final int typeId = 1;

  @override
  Vocabulary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vocabulary(
      arabicWord: fields[0] as String,
      transliteration: fields[1] as String,
      meaning: fields[2] as String,
      ayahReference: fields[3] as String,
      ayahTranslation: fields[4] as String,
      status: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Vocabulary obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.arabicWord)
      ..writeByte(1)
      ..write(obj.transliteration)
      ..writeByte(2)
      ..write(obj.meaning)
      ..writeByte(3)
      ..write(obj.ayahReference)
      ..writeByte(4)
      ..write(obj.ayahTranslation)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabularyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
