import 'dart:async';
import '../models/vocabulary.dart';

class VocabularyDataSource {
  Future<List<Vocabulary>> fetchVocabularyData([DateTime? lastFetched]) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    // Initial vocabulary items
    List<Vocabulary> vocabularyList = [
      Vocabulary(
        arabicWord: 'عَسَل',
        transliteration: "'asal",
        meaning: "Honey",
        ayahReference: "وَأَنْهَارٌ مِنْ عَسَلٍ مُصَفًّى\n(Muhammad 47:15)",
        ayahTranslation: "نہریں بہ رہی ہوں گی صاف شفاف شہد کی",
        status: "Latest",
      ),
      Vocabulary(
        arabicWord: 'مَاء',
        transliteration: "'maa",
        meaning: "Water",
        ayahReference:
            "وَجَعَلْنَا مِنَ الْمَاءِ كُلَّ شَيْءٍ حَيٍّ\n(Al-Anbiya 21:30)",
        ayahTranslation: "اور ہم نے پانی سے ہر زندہ چیز کو پیدا کیا",
        status: "Latest",
      ),
    ];

    // Simulate new items if `lastFetched` is before a certain date
    if (lastFetched == null || lastFetched.isBefore(DateTime.now())) {
      vocabularyList.addAll([
        Vocabulary(
          arabicWord: 'نَار',
          transliteration: "'naar",
          meaning: "Fire",
          ayahReference:
              "كُلَّمَا نَضِجَتْ جُلُودُهُمْ بَدَّلْنَاهُمْ جُلُودًا غَيْرَهَا\n(An-Nisa 4:56)",
          ayahTranslation:
              "جب ان کی کھالیں پک جائیں گی، ہم انہیں نئی کھالیں بدل دیں گے",
          status: "Latest",
        ),
        Vocabulary(
          arabicWord: 'خُبْز',
          transliteration: "'khubz",
          meaning: "Bread",
          ayahReference:
              "وَلَا يُطْعِمُونَ الطَّعَامَ عَلَى حُبِّهِ مِسْكِينًا وَيَتِيمًا وَأَسِيرًا\n(Ad-Dahr 76:8)",
          ayahTranslation:
              "اور (کھانا) کھلاتے ہیں اس کی محبت میں مسکین کو اور یتیم کو اور قیدی کو",
          status: "Latest",
        ),
        Vocabulary(
          arabicWord: 'نُور',
          transliteration: "'noor",
          meaning: "Light",
          ayahReference:
              "اللَّهُ نُورُ السَّمَاوَاتِ وَالْأَرْضِ\n(An-Nur 24:35)",
          ayahTranslation: "اللہ آسمانوں اور زمین کا نور ہے",
          status: "Latest",
        ),
        Vocabulary(
          arabicWord: 'قَمَر',
          transliteration: "'qamar",
          meaning: "Moon",
          ayahReference: "وَالْقَمَرِ إِذَا تَلَاهَا\n(Ash-Shams 91:2)",
          ayahTranslation: "اور چاند کی قسم جب وہ اس کے پیچھے آئے",
          status: "Latest",
        ),
        Vocabulary(
          arabicWord: 'شَمْس',
          transliteration: "'shams",
          meaning: "Sun",
          ayahReference: "وَالشَّمْسِ وَضُحَاهَا\n(Ash-Shams 91:1)",
          ayahTranslation: "سورج کی قسم اور اس کی روشنی کی",
          status: "Latest",
        ),
        Vocabulary(
          arabicWord: 'حَيَاة',
          transliteration: "'hayah",
          meaning: "Life",
          ayahReference:
              "وَمَا الْحَيَاةُ الدُّنْيَا إِلَّا مَتَاعُ الْغُرُورِ\n(Aal-e-Imran 3:185)",
          ayahTranslation:
              "اور دنیا کی زندگی دھوکے کے سامان کے سوا کچھ بھی نہیں",
          status: "Latest",
        ),
        Vocabulary(
          arabicWord: 'كِتَاب',
          transliteration: "'kitab",
          meaning: "Book",
          ayahReference:
              "ذَٰلِكَ الْكِتَابُ لَا رَيْبَ فِيهِ\n(Al-Baqarah 2:2)",
          ayahTranslation: "یہ کتاب، اس میں کوئی شک نہیں",
          status: "Latest",
        ),
        Vocabulary(
          arabicWord: 'رَحْمَة',
          transliteration: "'rahma",
          meaning: "Mercy",
          ayahReference: "وَرَحْمَتِي وَسِعَتْ كُلَّ شَيْءٍ\n(Al-A'raf 7:156)",
          ayahTranslation: "اور میری رحمت ہر چیز پر محیط ہے",
          status: "Latest",
        ),
        Vocabulary(
          arabicWord: 'صَبْر',
          transliteration: "'sabr",
          meaning: "Patience",
          ayahReference: "إِنَّ اللَّهَ مَعَ الصَّابِرِينَ\n(Al-Baqarah 2:153)",
          ayahTranslation: "بیشک اللہ صبر کرنے والوں کے ساتھ ہے",
          status: "Latest",
        ),
      ]);
    }

    return vocabularyList;
  }
}
