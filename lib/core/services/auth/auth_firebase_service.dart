import 'dart:async';
import 'package:chat_app/core/models/chat_user.dart';
import 'package:chat_app/core/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;
  static final _userStream = Stream<ChatUser?>.multi(
    (controller) async {
      final authChanges = FirebaseAuth.instance.authStateChanges();
      await for (final user in authChanges) {
        _currentUser = user == null ? null : _toChatUser(user);
        controller.add(_currentUser);
      }
    },
  );

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signup(String name, String email, String password, Uint8List? image) async {
    final signup = await Firebase.initializeApp(
      name: 'userSignup',
      options: Firebase.app().options,
    );

    final auth = FirebaseAuth.instanceFor(app: signup);
    UserCredential credentials = await auth.createUserWithEmailAndPassword(email: email, password: password);

    if (credentials.user == null) return;

    final imageName = '${credentials.user!.uid}.jpg';
    final imageUrl = await _uploadUserImage(image, imageName);

    await credentials.user!.updateDisplayName(name);
    await credentials.user!.updatePhotoURL(imageUrl);

    await _saveChatUser(_toChatUser(credentials.user!, imageUrl));

    await signup.delete();
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<String?> _uploadUserImage(Uint8List? image, String imageName) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);

    await imageRef.putData(image).whenComplete(() {});

    return await imageRef.getDownloadURL();
  }

  Future<void> _saveChatUser(ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final userRef = store.collection('users').doc(user.id);

    return userRef.set({
      'name': user.name,
      'email': user.email,
      'imageUrl': user.imageUrl,
    });
  }

  Future<Uint8List> assetToUint8List(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    return Uint8List.view(data.buffer);
  }

  static ChatUser _toChatUser(User user, [String? imageUrl]) {
    return ChatUser(
      id: user.uid,
      name: user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageUrl: user.photoURL ?? imageUrl ?? 'assets/images/avatar.png',
    );
  }
}
