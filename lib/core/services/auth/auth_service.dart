import 'dart:io';
import 'dart:ui';

import 'package:chat_app/core/models/chat_user.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthService {
  ChatUser? get currentUser;

  Stream<ChatUser?> get userChanges;

  Future<void> signup(String name, String email, String password, File image);
  Future<void> login(String email, String password);
  Future<void> logout();
}
