import 'package:chat_app2/chatting/chat/chat_bubbles.dart';
import 'package:chat_app2/config/palette.dart';
import 'package:chat_app2/service/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  const Messages({
    super.key,
  });

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  Stream<QuerySnapshot>? chats;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getChats();
  }

  getChats() {
    DatabaseService().getChats().then((value) {
      setState(() {
        chats = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final chatDocs = snapshot.data.docs;
          return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (context, index) {
              return ChatBubbles(
                message: chatDocs[index]['text'],
                sentByMe: chatDocs[index]['userID'].toString() == user!.uid,
                userName: chatDocs[index]['userName'],
                userID: chatDocs[index]['userID'],
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Palette.activeColor,
          ),
        );
      },
    );
  }
}
