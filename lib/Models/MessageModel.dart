class MessageModel {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;

  const MessageModel({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
  });

  factory MessageModel.fromUser(String content) => MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        isUser: true,
        timestamp: DateTime.now(),
      );

  factory MessageModel.fromAI(String content) => MessageModel(
        id: '${DateTime.now().millisecondsSinceEpoch}_ai',
        content: content,
        isUser: false,
        timestamp: DateTime.now(),
      );

  @override
  String toString() =>
      'MessageModel(id: $id, isUser: $isUser, content: ${content.substring(0, content.length.clamp(0, 40))}...)';
}
