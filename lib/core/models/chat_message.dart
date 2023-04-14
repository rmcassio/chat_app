import 'dart:typed_data';

class ChatMessage {
  final String id;
  final String text;
  final DateTime createdAt;

  final String userId;
  final String userName;
  final Uint8List userImage;

  ChatMessage({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.userImage,
  });
}
