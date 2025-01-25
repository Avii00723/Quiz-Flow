import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final List<Map<String, dynamic>> selectedAnswers;
  final List<Map<String, dynamic>> questions;

  const ResultPage({
    required this.score,
    required this.selectedAnswers,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              'Your Score: $score',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            ...List.generate(selectedAnswers.length, (index) {
              final selectedAnswer = selectedAnswers[index];
              final question = questions[index];
              final correctAnswer = question['options']
                  .firstWhere((option) => option['is_correct'] == true)['description'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Q${index + 1}: ${question['description']}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your Answer: ${selectedAnswer['selectedAnswer']}',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  Text(
                    'Correct Answer: $correctAnswer',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
              child: const Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
