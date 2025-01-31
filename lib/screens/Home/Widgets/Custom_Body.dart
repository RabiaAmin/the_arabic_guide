import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:the_arabic_guide_app/models/quiz.dart';
import 'package:the_arabic_guide_app/repositories/quiz_repository.dart';
import 'package:the_arabic_guide_app/screens/Quiz/quiz.dart';
import 'package:the_arabic_guide_app/screens/vocabulary/Vocab_Screen.dart';
import 'package:the_arabic_guide_app/utils/constants.dart';
import 'package:the_arabic_guide_app/utils/routes.dart';
import 'package:the_arabic_guide_app/utils/sizeConfig.dart';
import 'package:the_arabic_guide_app/screens/Home/Widgets/Vocabulary_Performance_Widget.dart';
import 'package:the_arabic_guide_app/widgets/cards.dart';
import 'package:the_arabic_guide_app/screens/Home/Widgets/imageSlider.dart';
import 'package:the_arabic_guide_app/repositories/vocabulary_local_repository.dart';

class CustomBody extends StatefulWidget {
  const CustomBody({super.key});

  @override
  State<CustomBody> createState() => _CustomBodyState();
}

class _CustomBodyState extends State<CustomBody> {
  final VocabularyLocalRepository repository =
      GetIt.I<VocabularyLocalRepository>();

  int reviewingCount = 0;
  int revisableCount = 0;
  int learnedCount = 0;

  @override
  void initState() {
    super.initState();
    fetchVocabularyCounts();
  }

  // Fetch the vocabulary counts based on their status
  void fetchVocabularyCounts() {
    setState(() {
      reviewingCount = repository.getVocabularyCountByStatus("Latest");
      revisableCount = repository.getVocabularyCountByStatus("Reviewable");
      learnedCount = repository.getVocabularyCountByStatus("Learned");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SizeConfig.blockH! * 100,
      color: kAccentColor,
      child: Column(
        children: [
          const ImageSlider(),
          SizedBox(
            height: SizeConfig.blockH! * 1,
          ),
          // Pass the fetched counts to VocabularyPerformanceWidget
          VocabularyPerformanceWidget(
            reviewing: reviewingCount,
            revisable: revisableCount,
            learned: learnedCount,
          ),
          MyCard(
            text: "See latest vocabularies",
            bgColor: kdark,
            backgroundImage: null, // This will show a solid color background
            backgroundColor:
                KBaseColor, // Fallback color if no image is provided
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const VocabularyScreen(status: "Latest"),
                ),
              );
            },
          ),
          MyCard(
            text: "Lets test your knowledge",
            bgColor: Colors.white,
            backgroundImage:
                'assets/images/bg.png', // Replace with your asset path
            backgroundColor: Colors.transparent,
            onTap: () {
              // Fetch quiz questions using QuizService
              final QuizRepository quizService = GetIt.I<QuizRepository>();
              List<QuizQuestion> questions =
                  quizService.generateQuiz(5); // Generate 5 questions

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(questions: questions),
                ),
              );
            }, // Optional if no background image
          ),
          Row(
            children: [
              MyCard(
                text: "Learned vocabs",
                CardWidth: SizeConfig.blockW! * 45,
                bgColor: kdark,
                backgroundImage:
                    null, // This will show a solid color background
                backgroundColor:
                    KBaseColor, // Fallback color if no image is provided
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const VocabularyScreen(status: "Learned"),
                    ),
                  );
                },
                iconShow: false,
              ),
              MyCard(
                CardWidth: SizeConfig.blockW! * 45,
                text: "Review & Retain",
                bgColor: kdark,
                backgroundImage:
                    null, // This will show a solid color background
                backgroundColor:
                    KBaseColor, // Fallback color if no image is provided
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const VocabularyScreen(status: "Reviewable"),
                    ),
                  );
                },
                iconShow: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
