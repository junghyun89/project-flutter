import 'package:chat_app2/service/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';

class ChatBubbles extends StatefulWidget {
  final String message;
  final String userName;
  final bool sentByMe;
  final String userID;
  final Timestamp sentTime;

  const ChatBubbles({
    super.key,
    required this.message,
    required this.userName,
    required this.sentByMe,
    required this.userID,
    required this.sentTime,
  });

  @override
  State<ChatBubbles> createState() => _ChatBubblesState();
}

class _ChatBubblesState extends State<ChatBubbles> {
  String? chatUserImage;

  @override
  void initState() {
    super.initState();
    getChatUserImage();
    time();
  }

  getChatUserImage() {
    DatabaseService().getUserImage(widget.userID).then((value) {
      setState(() {
        chatUserImage = value;
      });
    });
  }

  time() {
    DateTime time =
        DateTime.fromMillisecondsSinceEpoch(widget.sentTime.seconds * 1000);
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Stack(children: [
        Row(
          mainAxisAlignment:
              widget.sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (widget.sentByMe)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(),
                    ChatBubble(
                      clipper: ChatBubbleClipper6(type: BubbleType.sendBubble),
                      alignment: Alignment.topRight,
                      margin: const EdgeInsets.only(top: 5),
                      backGroundColor: Colors.blue,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: Column(
                          crossAxisAlignment: widget.sentByMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.message,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (!widget.sentByMe)
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 15),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: chatUserImage == null
                          ? null
                          : NetworkImage(chatUserImage!),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            widget.userName,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ChatBubble(
                          clipper: ChatBubbleClipper6(
                              type: BubbleType.receiverBubble),
                          backGroundColor: const Color(0xffE7E7ED),
                          margin: const EdgeInsets.only(top: 5),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Column(
                              crossAxisAlignment: widget.sentByMe
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.message,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
          ],
        ),
      ]),
    );
  }
}
