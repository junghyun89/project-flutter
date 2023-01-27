import 'package:chat_app2/config/palette.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool sentByMe;

  const ChatBubble({
    super.key,
    required this.message,
    required this.sentByMe,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: sentByMe ? Colors.grey[300] : Palette.activeColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: sentByMe
                  ? const Radius.circular(12)
                  : const Radius.circular(0),
              bottomRight: sentByMe
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
            ),
          ),
          width: 145,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          child: Text(
            message,
            style: TextStyle(
              color: sentByMe ? Colors.black : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
