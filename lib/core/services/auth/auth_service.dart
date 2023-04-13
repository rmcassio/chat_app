import 'dart:io';
import 'dart:typed_data';

import 'package:chat_app/core/models/chat_user.dart';

abstract class AuthService {
  ChatUser? get currentUser;

  Stream<ChatUser?> get userChanges;

  Future<void> signup(String name, String email, String password, Uint8List? image);
  Future<void> login(String email, String password);
  Future<void> logout();
}
