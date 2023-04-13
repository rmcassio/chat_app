import 'package:chat_app/core/services/auth/auth_service_mock.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Chat Page'),
            SizedBox(height: 8),
            TextButton(
              onPressed: () => AuthServiceMock().logout(),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
