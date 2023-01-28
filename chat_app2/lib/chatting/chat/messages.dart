import 'package:chat_app2/chatting/chat/chat_bubbles.dart';
import 'package:chat_app2/config/palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('time', descending: true)
          .snapshots(),
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
