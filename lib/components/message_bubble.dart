import 'dart:typed_data';

import 'package:chat_app/core/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isLoggedUserMessage;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isLoggedUserMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: isLoggedUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: !isLoggedUserMessage ? Colors.grey.shade300 : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomRight: !isLoggedUserMessage ? const Radius.circular(12) : Radius.zero,
                  bottomLeft: isLoggedUserMessage ? const Radius.circular(12) : Radius.zero,
                ),
              ),
              width: 180,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: Column(
                children: [
                  Text(
                    message.userName,
                    style: TextStyle(
                      color: isLoggedUserMessage ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    message.text,
                    style: TextStyle(
                      color: isLoggedUserMessage ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isLoggedUserMessage ? null : 165,
          right: !isLoggedUserMessage ? null : 165,
          child: _showUserImage(null, 'assets/images/avatar.png'),
        ),
      ],
    );
  }

  Widget _showUserImage(Uint8List? image, String? url) {
    ImageProvider? provider;
    if (image != null) {
      provider = MemoryImage(image);
    } else {
      provider = const AssetImage('assets/images/avatar.png');
    }

    return CircleAvatar(
      backgroundColor: Colors.pink,
      backgroundImage: provider,
    );
  }
}
