import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:orbit/src/models/note.dart'; // Assumer que Note est là
import 'dart:convert';

class AiService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const String _apiUrl = 'https://api.openai.com/v1/chat/completions';

  Future<Map<String, dynamic>> analyzeNote(Note note) async {
    final apiKey = await _storage.read(key: 'openai_api_key');
    if (apiKey == null) {
      throw Exception('Grok API key not found');
    }

    final prompt = '''
Analyze this note and extract structured data:
- Family members (e.g., names of children, spouse)
- Interests (e.g., hobbies, preferences)
- Upcoming events or dates (e.g., birthdays, school starts)
- Suggested reminders (e.g., "Ask about daughter's first day at school tomorrow")

Note content: ${note.content}

Return as JSON: {
  "family": ["Léa: daughter"],
  "interests": ["Whisky japonais"],
  "events": [{"date": "tomorrow", "description": "Léa starts CP"}],
  "reminders": [{"text": "Demander comment s'est passée la rentrée de Léa", "dueDate": "2023-11-24"}]
}
''';

    try {
      final response = await _dio.post(
        _apiUrl,
        options: Options(headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        }),
        data: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'system', 'content': 'You are a helpful assistant that extracts contact info from notes.'},
            {'role': 'user', 'content': prompt},
          ],
          'temperature': 0.3,
        }),
      );

      final jsonResponse = jsonDecode(response.data['choices'][0]['message']['content']);
      return jsonResponse;
    } catch (e) {
      throw Exception('Failed to analyze note: $e');
    }
  }
}

  Future<void> setApiKey(String apiKey) async {
    await _storage.write(key: \"openai_api_key\", value: apiKey);
  }

