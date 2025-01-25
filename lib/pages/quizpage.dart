import 'dart:async';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final List<Map<String, dynamic>> questions;

  const QuizPage({required this.questions});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  List<Map<String, dynamic>> selectedAnswers = [];
  bool isAnswerSelected = false;
  int timerSeconds = 900; // 15 minutes in seconds
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds > 0) {
        setState(() {
          timerSeconds--;
        });
      } else {
        _goToResultPage();
      }
    });
  }

  void onAnswerSelected(bool isCorrect, String selectedOption) {
    setState(() {
      selectedAnswers.add({
        'question': widget.questions[currentQuestionIndex]['description'],
        'selectedAnswer': selectedOption,
        'isCorrect': isCorrect,
      });

      if (isCorrect) {
        score += 4;
      } else {
        score -= 1;
      }

      isAnswerSelected = true;
    });
  }

  void _goToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < widget.questions.length - 1) {
        currentQuestionIndex++;
        isAnswerSelected = false;
      } else {
        _goToResultPage();
      }
    });
  }

  void _goToResultPage() {
    Navigator.pushReplacementNamed(
      context,
      '/result',
      arguments: {
        'score': score,
        'selectedAnswers': selectedAnswers,
        'questions': widget.questions,
      },
    );
  }


  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];
    final questionText = question['description'] ?? 'Question not available';
    final options = question['options'] ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Time Left: ${_formatTime(timerSeconds)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Question ${currentQuestionIndex + 1}/${widget.questions.length}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              questionText,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),
            if (options.isEmpty)
              const Text(
                'No options available for this question.',
                style: TextStyle(color: Colors.red, fontSize: 16),
              )
            else
              ...List.generate(
                options.length,
                    (index) {
                  final optionText = options[index]['description'] ?? 'Option not available';
                  final isCorrect = options[index]['is_correct'] ?? false;

                  bool isSelected = false;
                  if (isAnswerSelected) {
                    isSelected = selectedAnswers.last['selectedAnswer'] == optionText;
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          isAnswerSelected
                              ? (isSelected
                              ? isCorrect
                              ? Colors.green // Correct answer
                              : Colors.red // Incorrect answer
                              : Colors.grey) // Default color if not selected
                              : Colors.blueAccent, // Default button color before selection
                        ),
                      ),
                      onPressed: isAnswerSelected
                          ? null // Disable buttons after selecting an answer
                          : () => onAnswerSelected(isCorrect, optionText),
                      child: Text(optionText),
                    ),
                  );
                },
              ),
            const SizedBox(height: 20),
            if (isAnswerSelected)
              ElevatedButton(
                onPressed: _goToNextQuestion,
                child: const Text('Next Question'),
              ),
          ],
        ),
      ),
    );
  }
}
