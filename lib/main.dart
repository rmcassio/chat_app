import 'package:chat_app/core/services/notification/chat_notification_service.dart';
import 'package:chat_app/pages/auth_or_app_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCwHGP0rkBGmI4R9o0N0G3M3lwuul3EFfU',
      appId: '1:100023785497:web:4a4d2efc5d18bdc5e97288',
      messagingSenderId: '100023785497',
      projectId: 'opper-chat',
      storageBucket: 'opper-chat.appspot.com',
      
      
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatNotificationService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthOrAppPage(),
      ),
    );
  }
}
