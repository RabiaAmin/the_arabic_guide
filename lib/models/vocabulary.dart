import 'package:hive/hive.dart';

part 'vocabulary.g.dart';

@HiveType(typeId: 1)
class Vocabulary extends HiveObject {
  @HiveField(0)
  final String arabicWord;

  @HiveField(1)
  final String transliteration;

  @HiveField(2)
  final String meaning;

  @HiveField(3)
  final String ayahReference;

  @HiveField(4)
  final String ayahTranslation;

  @HiveField(5)
  String status; // "Learned" or "Reviewable"

  Vocabulary({
    required this.arabicWord,
    required this.transliteration,
    required this.meaning,
    required this.ayahReference,
    required this.ayahTranslation,
    this.status = "Latest",
  });
}
