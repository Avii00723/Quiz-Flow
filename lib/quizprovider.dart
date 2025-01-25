import 'package:flutter/material.dart';

class QuizProvider with ChangeNotifier {
  List<dynamic> selectedAnswers = [];
  int currentQuestionIndex = 0;
  bool isAnswerSelected = false;
  int score = 0;

  void onAnswerSelected(bool isCorrect, String selectedOption) {
    if (currentQuestionIndex < selectedAnswers.length) {
      selectedAnswers[currentQuestionIndex] = {
        'question': selectedAnswers[currentQuestionIndex]['description'],
        'selectedAnswer': selectedOption,
        'isCorrect': isCorrect,
      };
    } else {
      selectedAnswers.add({
        'question': selectedAnswers[currentQuestionIndex]['description'],
        'selectedAnswer': selectedOption,
        'isCorrect': isCorrect,
      });
    }

    if (isCorrect) {
      score += 4;
    } else {
      score -= 1;
    }

    isAnswerSelected = true;
    notifyListeners();
  }

  void nextQuestion() {
    if (currentQuestionIndex < selectedAnswers.length - 1) {
      currentQuestionIndex++;
      isAnswerSelected = false;
      notifyListeners();
    }
  }

  String formatTime() {
    return "00:00";
  }
}
