import 'package:flutter/material.dart';
import 'package:whatsapp/domain/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.seenIcon,
    required this.imgUrl,
    required this.isComing,
  });

  final MessageModel message;
  final String time;
  final IconData seenIcon;
  final String imgUrl;
  final bool isComing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isComing ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.yellow),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width / 2,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                imgUrl == ""
                    ? Text(message.msg!)
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(imgUrl, fit: BoxFit.cover),
                        const SizedBox(height: 11),
                        Text(message.msg!),
                      ],
                    ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment:
              isComing ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.yellow),
              child: Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      isComing
                          ? Text(time)
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(time),
                              const SizedBox(width: 6),
                              Icon(seenIcon),
                            ],
                          ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
