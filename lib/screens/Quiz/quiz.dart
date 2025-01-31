import 'package:flutter/material.dart';
import 'package:the_arabic_guide_app/models/quiz.dart';
import 'package:the_arabic_guide_app/utils/constants.dart';
import 'package:the_arabic_guide_app/utils/routes.dart';
import 'package:the_arabic_guide_app/utils/sizeConfig.dart';

class QuizScreen extends StatefulWidget {
  final List<QuizQuestion> questions;

  const QuizScreen({super.key, required this.questions});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;

  void answerQuestion(String answer) {
    setState(() {
      if (answer == widget.questions[currentQuestionIndex].correctAnswer) {
        score++;
      }
      currentQuestionIndex++;
    });
  }

  // Method to reset the quiz
  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex >= widget.questions.length) {
      // Quiz finished
      return Material(
        color: kAccentColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quiz Complete!",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
            ),
            Text(
              "Your score: $score/${widget.questions.length}",
              style: TextStyle(fontSize: 18, color: Colors.teal),
            ),
            SizedBox(
              height: SizeConfig.blockH! * 6,
            ),
            ElevatedButton(
              onPressed: resetQuiz,
              style: ElevatedButton.styleFrom(
                fixedSize:
                    Size(SizeConfig.blockW! * 75, SizeConfig.blockH! * 4),
                backgroundColor: kSecondaryColor,
              ),
              child: Text(
                " Try Again?",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () => {Navigator.pushNamed(context, Routes.home)},
              style: ElevatedButton.styleFrom(
                fixedSize:
                    Size(SizeConfig.blockW! * 75, SizeConfig.blockH! * 4),
                backgroundColor: kSecondaryColor,
              ),
              child: Text(
                "Home",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      );
    }

    QuizQuestion currentQuestion = widget.questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        foregroundColor: KBaseColor,
        title: const Text(
          'Lets Test Your Knowledge',
        ),
      ),
      body: SizedBox(
        width: SizeConfig.blockH! * 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(currentQuestion.question, style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ...currentQuestion.options.map((option) {
              return ElevatedButton(
                onPressed: () => answerQuestion(option),
                style: ElevatedButton.styleFrom(
                  fixedSize:
                      Size(SizeConfig.blockW! * 75, SizeConfig.blockH! * 3),
                  backgroundColor: kSecondaryColor,
                ),
                child: Text(
                  option,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
