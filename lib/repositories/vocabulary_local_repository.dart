import 'package:hive/hive.dart';
import '../models/vocabulary.dart';

class VocabularyLocalRepository {
  final Box<Vocabulary> vocabularyBox = Hive.box<Vocabulary>('vocabularyBox');
  final Box<DateTime> timestampBox = Hive.box<DateTime>('fetchTimestamps');

  // Save a vocabulary item to Hive
  Future<void> addVocabularyToHive(Vocabulary vocab) async {
    await vocabularyBox.put(
        vocab.arabicWord, vocab); // Using arabicWord as a unique key
  }

  // Retrieve vocabulary items by status from Hive
  List<Vocabulary> getVocabularyByStatus(String status) {
    return vocabularyBox.values
        .where((vocab) => vocab.status == status)
        .toList();
  }

  // Get the count of vocabulary items by status from Hive
  int getVocabularyCountByStatus(String status) {
    return vocabularyBox.values.where((vocab) => vocab.status == status).length;
  }

  // Get the last fetch timestamp for new vocabulary
  DateTime getLastFetchTimestamp() {
    return timestampBox.get('lastFetched') ??
        DateTime.fromMillisecondsSinceEpoch(0);
  }

  // Update the last fetch timestamp after new items are fetched
  Future<void> updateLastFetchTimestamp(DateTime timestamp) async {
    await timestampBox.put('lastFetched', timestamp);
  }

  // Update vocabulary status and store the change in Hive
  Future<void> updateVocabularyStatus(
      Vocabulary vocab, String newStatus) async {
    vocab.status = newStatus;
    await vocabularyBox.put(vocab.arabicWord, vocab); // Update by unique key
  }

  // Retrieve learned vocabulary
  List<Vocabulary> getLearnedVocabulary() {
    return vocabularyBox.values
        .where((vocab) => vocab.status == "Learned")
        .toList();
  }
}
