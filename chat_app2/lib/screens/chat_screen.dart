import 'dart:io';

import 'package:chat_app2/add_image/add_image.dart';
import 'package:chat_app2/chatting/chat/messages.dart';
import 'package:chat_app2/chatting/chat/new_message.dart';
import 'package:chat_app2/config/palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  late String userName = '';
  File? userImage;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getUserName();
  }

  getUserName() async {
    final userData = await FirebaseFirestore.instance
        .collection('user')
        .doc(loggedUser!.uid)
        .get();
    userName = userData.data()!['userName'];
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat screen'),
        backgroundColor: Palette.activeColor,
        actions: [
          IconButton(
            onPressed: () {
              _authentication.signOut();
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
          ),
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[700],
              backgroundImage: userImage != null ? FileImage(userImage!) : null,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              userName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {
                showPopUp(context);
              },
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              leading: const Icon(Icons.edit),
              title: const Text(
                'Edit Profile Image',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: Column(children: const [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ]),
        ),
      ),
    );
  }

  showPopUp(context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Dialog(
          backgroundColor: Colors.white,
          child: AddImage(),
        );
      },
    );
  }
}
