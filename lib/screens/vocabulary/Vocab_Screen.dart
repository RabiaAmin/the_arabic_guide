import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:the_arabic_guide_app/repositories/vocabulary_repository.dart';
import 'package:the_arabic_guide_app/utils/constants.dart';
import 'package:the_arabic_guide_app/utils/sizeConfig.dart';
import '../../models/vocabulary.dart';

class VocabularyScreen extends StatefulWidget {
  final String status; // This determines which status to display

  const VocabularyScreen({super.key, required this.status});

  @override
  _VocabularyScreenState createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  final VocabularyRepository repository = GetIt.I<VocabularyRepository>();
  late Future<List<Vocabulary>> vocabFuture;

  @override
  void initState() {
    super.initState();
    fetchVocabularies();
  }

  void fetchVocabularies() {
    // Fetch vocabularies based on the status passed to this widget
    if (widget.status == "Latest") {
      vocabFuture = repository.fetchLatestVocabularies();
    } else {
      vocabFuture = Future.value(
        repository.localRepository.getVocabularyByStatus(widget.status),
      );
    }
  }

  void updateVocabularyStatus(Vocabulary vocab, String newStatus) async {
    await repository.updateVocabularyStatus(vocab, newStatus);
    setState(() {
      fetchVocabularies(); // Refresh the list to exclude updated items
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kPrimaryColor,
        title: Text("${widget.status} Vocabs"),
      ),
      body: FutureBuilder<List<Vocabulary>>(
        future: vocabFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No vocabularies found."));
          } else {
            final vocabList = snapshot.data!;
            return ListView.builder(
              itemCount: vocabList.length,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                return buildVocabCard(vocabList[index]);
              },
            );
          }
        },
      ),
    );
  }

  Widget buildVocabCard(Vocabulary vocab) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vocabulary Details
            Text(
              vocab.arabicWord,
              style: TextStyle(
                fontSize: 32,
                color: Colors.teal[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "(noun) ${vocab.transliteration}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              vocab.meaning,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24, thickness: 1, color: Colors.teal),

            // Ayah Reference
            const Text(
              "Ayah Reference",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              vocab.ayahReference,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              vocab.ayahTranslation,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 16),

            // Action Buttons based on the status
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.status == "Latest" || widget.status == "Reviewable")
                  ElevatedButton(
                    onPressed: () => updateVocabularyStatus(vocab, "Learned"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryColor,
                    ),
                    child: const Text(
                      "Learned",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                SizedBox(width: SizeConfig.blockW! * 3),
                if (widget.status == "Latest" || widget.status == "Learned")
                  ElevatedButton(
                    onPressed: () =>
                        updateVocabularyStatus(vocab, "Reviewable"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryColor,
                    ),
                    child: const Text(
                      "Reviewable",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
