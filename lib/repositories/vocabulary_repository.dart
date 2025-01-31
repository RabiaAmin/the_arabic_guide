import '../data/vocabulary_data_source.dart';
import '../models/vocabulary.dart';
import 'vocabulary_local_repository.dart';

class VocabularyRepository {
  final VocabularyDataSource dataSource;
  final VocabularyLocalRepository localRepository;

  VocabularyRepository(this.dataSource, this.localRepository);

  // Fetch and merge only new vocabulary items with local data
  Future<List<Vocabulary>> fetchLatestVocabularies() async {
    final lastFetched = localRepository.getLastFetchTimestamp();
    List<Vocabulary> newVocabItems =
        await dataSource.fetchVocabularyData(lastFetched);

    // Store only new items in Hive to avoid overwriting existing status
    for (final vocab in newVocabItems) {
      if (!localRepository.vocabularyBox.containsKey(vocab.arabicWord)) {
        await localRepository.addVocabularyToHive(vocab);
      }
    }

    // Update the last fetched timestamp only if new items were added
    if (newVocabItems.isNotEmpty) {
      await localRepository.updateLastFetchTimestamp(DateTime.now());
    }

    // Return only "Latest" vocabulary items from local storage
    return localRepository.getVocabularyByStatus("Latest");
  }

  // Update vocabulary status and store in Hive
  Future<void> updateVocabularyStatus(
      Vocabulary vocab, String newStatus) async {
    await localRepository.updateVocabularyStatus(vocab, newStatus);
  }
}
