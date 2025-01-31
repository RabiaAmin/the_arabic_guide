import 'dart:math';
import 'package:the_arabic_guide_app/models/quiz.dart';

import '../models/vocabulary.dart';
import 'vocabulary_local_repository.dart';

class QuizRepository {
  final VocabularyLocalRepository repository;

  QuizRepository(this.repository);

  List<QuizQuestion> generateQuiz(int numberOfQuestions) {
    List<Vocabulary> learnedVocabulary = repository.getLearnedVocabulary();

    if (learnedVocabulary.isEmpty) {
      return []; // No questions if no learned vocabulary
    }

    // Randomize the vocabulary list
    learnedVocabulary.shuffle();

    // Limit the number of questions to the available learned vocabulary count
    int quizSize = min(numberOfQuestions, learnedVocabulary.length);

    List<QuizQuestion> quizQuestions = [];

    for (int i = 0; i < quizSize; i++) {
      Vocabulary vocab = learnedVocabulary[i];

      // Generate incorrect options from other learned vocab
      List<String> incorrectOptions = learnedVocabulary
          .where((v) => v.meaning != vocab.meaning)
          .map((v) => v.meaning)
          .take(3) // Limit to 3 incorrect options
          .toList();

      // Shuffle options and add the correct answer
      List<String> options = [vocab.meaning, ...incorrectOptions];
      options.shuffle();

      // Create the quiz question
      quizQuestions.add(
        QuizQuestion(
          question: "What is the meaning of '${vocab.arabicWord}'?",
          correctAnswer: vocab.meaning,
          options: options,
        ),
      );
    }

    return quizQuestions;
  }
}
