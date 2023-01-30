import 'package:chat_app2/add_image/add_image.dart';
import 'package:chat_app2/chatting/chat/messages.dart';
import 'package:chat_app2/chatting/chat/new_message.dart';
import 'package:chat_app2/config/palette.dart';
import 'package:chat_app2/service/database_service.dart';
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
  String userName = '';
  String? userImage = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getUserName();
    getUserImage();
  }

  getUserName() async {
    DatabaseService().getUserName(loggedUser!.uid).then((value) {
      setState(() {
        userName = value;
      });
    });
  }

  getUserImage() async {
    DatabaseService().getUserImage(loggedUser!.uid).then((value) {
      setState(() {
        userImage = value;
      });
    });
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
            Center(
              child: userImage == ''
                  ? CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[700],
                    )
                  : ClipOval(
                      child: Image.network(
                        userImage!,
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
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
        return Dialog(
          backgroundColor: Colors.white,
          child: AddImage(
            loggedUser: loggedUser!,
          ),
        );
      },
    );
  }
}
