import 'package:chat_app2/service/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';

class ChatBubbles extends StatefulWidget {
  final String message;
  final String userName;
  final bool sentByMe;
  final String userID;

  const ChatBubbles({
    super.key,
    required this.message,
    required this.userName,
    required this.sentByMe,
    required this.userID,
  });

  @override
  State<ChatBubbles> createState() => _ChatBubblesState();
}

class _ChatBubblesState extends State<ChatBubbles> {
  String chatUserImage = '';

  @override
  void initState() {
    super.initState();
    getChatUserImage();
  }

  getChatUserImage() async {
    DatabaseService().getUserImage(widget.userID).then((value) {
      setState(() {
        chatUserImage = value;
      });
    });
    // final userData = await FirebaseFirestore.instance
    //     .collection('user')
    //     .doc(widget.userID)
    //     .get();
    // final imageUrl = userData.data()!['userImage'];
    // setState(() {
    //   if (imageUrl != null) {
    //     chatUserImage = imageUrl;
    //   } else {
    //     chatUserImage = '';
    //   }
    // });
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
                      backgroundImage: NetworkImage(chatUserImage),
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
