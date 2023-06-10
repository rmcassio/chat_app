import 'dart:typed_data';

class ChatUser {
  final String id;
  final String name;
  final String email;
  Uint8List? image;
  final String? imageUrl;

  ChatUser({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    this.imageUrl,
  });
}
