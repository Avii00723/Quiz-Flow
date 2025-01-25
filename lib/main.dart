import 'package:flutter/material.dart';
import 'package:testlineassignment/pages/quizpage.dart';
import 'package:testlineassignment/pages/resultpage.dart';
import 'package:testlineassignment/pages/startquizpage.dart';
import 'package:testlineassignment/service/quizservice.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primaryColor: Colors.blueAccent, // Primary color for AppBar, Buttons, etc.
        scaffoldBackgroundColor: Colors.white, // Background color for the app
        textTheme: TextTheme(
          headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black87),
          bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black54),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blueAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            textStyle: TextStyle(fontSize: 18), // Button text color
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder<List<dynamic>>(
          future: QuizService().fetchQuizData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return const Scaffold(
                body: Center(child: Text('Failed to load quiz data')),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Scaffold(
                body: Center(child: Text('No quiz data available')),
              );
            } else {
              return StartQuizPage(questions: snapshot.data!);
            }
          },
        ),
        '/quiz': (context) => QuizPage(
          questions: ModalRoute.of(context)?.settings.arguments as List<Map<String, dynamic>>? ?? [],
        ),
        '/result': (context) => ResultPage(
          score: ModalRoute.of(context)?.settings.arguments != null
              ? (ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>)['score'] as int
              : 0,
          selectedAnswers: ModalRoute.of(context)?.settings.arguments != null
              ? (ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>)['selectedAnswers'] as List<Map<String, dynamic>>
              : [],
          questions: ModalRoute.of(context)?.settings.arguments != null
              ? (ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>)['questions'] as List<Map<String, dynamic>>
              : [],
        ),
      },
    );
  }
}
