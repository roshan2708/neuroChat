import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Core/Constants.dart';
import '../Models/MessageModel.dart';

class GeminiService {
  String? _lastError;
  String? get lastError => _lastError;

  static const int _maxHistoryMessages = 20;

  Future<String?> generateResponse({
    required String userMessage,
    required List<MessageModel> history,
  }) async {
    try {
      _lastError = null;

      final url = Uri.parse(
        '${AppConstants.geminiBaseUrl}/${AppConstants.geminiModel}:generateContent'
        '?key=${AppConstants.geminiApiKey}',
      );

      final recentHistory = history.length > _maxHistoryMessages
          ? history.sublist(history.length - _maxHistoryMessages)
          : history;

      final contents = <Map<String, dynamic>>[];

      for (final msg in recentHistory) {
        if (msg == history.last) break;
        contents.add({
          'role': msg.isUser ? 'user' : 'model',
          'parts': [
            {'text': msg.content}
          ],
        });
      }

      contents.add({
        'role': 'user',
        'parts': [
          {'text': userMessage}
        ],
      });

      final body = jsonEncode({
        'system_instruction': {
          'parts': [
            {'text': AppConstants.systemPrompt}
          ],
        },
        'contents': contents,
        'generationConfig': {
          'temperature': 0.8,
          'maxOutputTokens': 1024,
          'topP': 0.95,
        },
      });

      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: body,
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final candidates = data['candidates'] as List<dynamic>?;

        if (candidates != null && candidates.isNotEmpty) {
          final content = candidates[0]['content'] as Map<String, dynamic>?;
          final parts = content?['parts'] as List<dynamic>?;
          if (parts != null && parts.isNotEmpty) {
            return parts[0]['text'] as String?;
          }
        }
        _lastError = 'No response from AI. Please try again.';
        return null;
      } else {
        final errorData = jsonDecode(response.body);
        _lastError = errorData['error']?['message'] ??
            'API error ${response.statusCode}';
        return null;
      }
    } on Exception catch (e) {
      _lastError = 'Network error: ${e.toString()}';
      return null;
    }
  }
}
