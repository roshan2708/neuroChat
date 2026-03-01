import 'package:flutter/material.dart';
import '../Models/MessageModel.dart';
import '../Services/GeminiService.dart';
import '../Core/Constants.dart';

class ChatProvider extends ChangeNotifier {
  final GeminiService _geminiService = GeminiService();

  final List<MessageModel> _messages = [];
  bool _isTyping = false;
  String? _errorMessage;

  List<MessageModel> get messages => List.unmodifiable(_messages);
  bool get isTyping => _isTyping;
  String? get errorMessage => _errorMessage;

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    final userMsg = MessageModel.fromUser(content.trim());
    _messages.add(userMsg);
    _errorMessage = null;
    notifyListeners();

    _isTyping = true;
    notifyListeners();

    await Future.delayed(AppConstants.typingDelay);

    final response = await _geminiService.generateResponse(
      userMessage: content.trim(),
      history: _messages,
    );

    _isTyping = false;

    if (response != null) {
      _messages.add(MessageModel.fromAI(response));
    } else {
      _errorMessage = _geminiService.lastError;
      _messages.add(
        MessageModel.fromAI(
          '⚠️ Sorry, I encountered an error. Please try again.',
        ),
      );
    }

    notifyListeners();
  }

  void clearChat() {
    _messages.clear();
    _errorMessage = null;
    notifyListeners();
  }
}
