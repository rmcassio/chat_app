import 'package:chat_app/core/models/chat_user.dart';
import 'package:chat_app/core/services/auth/auth_service_mock.dart';
import 'package:chat_app/pages/auth_page.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthServiceMock().userChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return snapshot.hasData ? const ChatPage() : const AuthPage();
          }
        },
      ),
    );
  }
}
