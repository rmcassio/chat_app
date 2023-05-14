import 'dart:math';

import 'package:chat_app/components/messages.dart';
import 'package:chat_app/components/new_message.dart';
import 'package:chat_app/core/models/chat_notification.dart';
import 'package:chat_app/core/services/auth/auth_service.dart';
import 'package:chat_app/core/services/notification/chat_notification_service.dart';
import 'package:chat_app/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opper Chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              alignment: Alignment.center,
              items: const [
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 10),
                      Text('Sair'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const NotificationPage();
                    },
                  ),
                ),
                icon: const Icon(Icons.notifications),
              ),
              Positioned(
                top: 8,
                right: 2,
                child: CircleAvatar(
                  backgroundColor: Colors.red.shade800,
                  maxRadius: 10,
                  child: Text(
                    Provider.of<ChatNotificationService>(context).itemsCount.toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: const SafeArea(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
