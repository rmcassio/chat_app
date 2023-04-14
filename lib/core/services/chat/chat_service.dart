import 'package:chat_app/core/models/chat_message.dart';
import 'package:chat_app/core/models/chat_user.dart';
import 'package:chat_app/core/services/chat/chat_service_mock.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messagesStream();
  Future<ChatMessage> save(String text, ChatUser user);

  factory ChatService() {
    return ChatServiceMock();
  }
}
