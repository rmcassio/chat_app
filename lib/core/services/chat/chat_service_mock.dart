import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:chat_app/core/models/chat_user.dart';
import 'package:chat_app/core/models/chat_message.dart';
import 'package:chat_app/core/services/chat/chat_service.dart';
import 'package:flutter/services.dart';

class ChatServiceMock implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'Bom dia',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Mário',
      userImage: Uint8List.fromList([1, 2, 3, 4, 5]),
    ),
    ChatMessage(
      id: '3',
      text: 'Bom day',
      createdAt: DateTime.now(),
      userId: '456',
      userName: 'Jairo',
      userImage: Uint8List.fromList([1, 2, 3, 4, 5]),
    ),
    ChatMessage(
      id: '6',
      text: 'Nice one',
      createdAt: DateTime.now(),
      userId: '33',
      userName: 'Cleber',
      userImage: Uint8List.fromList([1, 2, 3, 4, 5]),
    ),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    _controller?.add(_msgs);
  });

  Future<Uint8List> assetToUint8List(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    return Uint8List.view(data.buffer);
  }

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMsg = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImage: user.image!,
    );

    _msgs.add(newMsg);

    _controller?.add(_msgs);

    return newMsg;
  }
}
