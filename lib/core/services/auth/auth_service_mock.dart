import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:chat_app/core/models/chat_user.dart';
import 'package:chat_app/core/services/auth/auth_service.dart';
import 'package:flutter/services.dart';

class AuthServiceMock implements AuthService {
  static final _defaultUser = ChatUser(
    id: '456',
    name: 'Jairo',
    email: 'email@email',
    image: null,
  );

  static final Map<String, ChatUser> _users = {
    _defaultUser.email: _defaultUser,
  };
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUser);
  });

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  @override
  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  @override
  Future<void> signup(String name, String email, String password, Uint8List? image) async {
    Uint8List? assetData;
    if (image == null) {
      assetData = await assetToUint8List('assets/images/avatar.png');
    }

    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      image: image ?? assetData,
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }

  Future<Uint8List> assetToUint8List(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    return Uint8List.view(data.buffer);
  }
}
