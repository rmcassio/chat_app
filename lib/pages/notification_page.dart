import 'package:chat_app/core/services/notification/chat_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas notificações'),
      ),
      body: ListView.builder(
        itemCount: service.itemsCount,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items.elementAt(index).title),
            subtitle: Text(items.elementAt(index).body),
            onTap: () => service.remove(index),
          );
        },
      ),
    );
  }
}
