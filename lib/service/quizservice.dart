import 'dart:convert';
import 'package:http/http.dart' as http;

class QuizService {
  final String apiUrl = 'https://api.jsonserve.com/Uw5CrX';

  Future<List<Map<String, dynamic>>> fetchQuizData() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      return List<Map<String, dynamic>>.from(jsonData['questions'] ?? []);
    } else {
      throw Exception('Failed to load quiz data');
    }
  }
}
