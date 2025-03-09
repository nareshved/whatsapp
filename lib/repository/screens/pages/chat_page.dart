import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/data/bloc/users/user_bloc.dart';
import 'package:whatsapp/data/bloc/users/user_events.dart';
import 'package:whatsapp/data/firebase/firebase_provider.dart';
import 'package:whatsapp/domain/models/message_model.dart';
import '../../widgets/text_feild/text_field.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.toId, this.userId});

  final toId;
  final userId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();

  //   @override
  //   void initState() {
  //     super.initState();
  //     getAllmsg();
  //   }

  //   Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getAllmsg() async {
  //     // for get all msg for bloc firebase
  //     return FirebaseProvider.getAllMsg(toId: widget.toId);
  //   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        actions: const [
          Icon(Icons.call),
          SizedBox(width: 20),
          Icon(Icons.video_camera_back),
        ],
      ),

      // bottomSheet: ,
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseProvider.getAllMsg(
              toId: widget.toId,
              userId: widget.userId,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Text("error try again");
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    MessageModel eachMessage = MessageModel.fromDoc(
                      snapshot.data!.docs[index].data(),
                    );

                    var fromId = eachMessage.fromId;

                    if (fromId == widget.userId) {
                      return fromMsgWidget(msg: eachMessage);
                    } else {
                      return toMsgWidget(msg: eachMessage);
                    }
                  },
                );
              }

              return Container();
            },
          ),
          Container(
            // margin: const EdgeInsets.all(12),
            child: myTextField(
              suffIcon: IconButton(
                onPressed: () {
                  if (messageController.text.isNotEmpty) {
                    BlocProvider.of<UserBloc>(context).add(
                      SendMessageEvent(
                        userId: widget.userId,
                        msg: messageController.text.trim(),
                        toId: widget.toId,
                      ),
                    );
                  }
                  messageController.clear();
                },
                icon: const Icon(Icons.send),
              ),
              hinttxt: "message a new",
              mcrontroller: messageController,
              labelTxt: "message",
            ),
          ),
        ],
      ),
    );
  }

  // right
  Widget fromMsgWidget({required MessageModel msg}) {
    var sentTime = TimeOfDay.fromDateTime(
      DateTime.fromMillisecondsSinceEpoch(int.parse(msg.sentAt!)),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(sentTime.format(context)),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.all(11),
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(21),
                    topRight: Radius.circular(21),
                    bottomLeft: Radius.circular(21),
                  ),
                ),
                child:
                    msg.msgType == 0
                        ? Text(msg.msg!)
                        : Image.network(msg.imgUrl!),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: msg.readAt != "",
                    child: Text(
                      msg.readAt == ""
                          ? ""
                          : TimeOfDay.fromDateTime(
                            DateTime.fromMillisecondsSinceEpoch(
                              int.parse(msg.readAt!),
                            ),
                          ).format(context).toString(),
                    ),
                  ),
                  const SizedBox(width: 7),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.done_all_outlined,
                      color: msg.readAt != "" ? Colors.blue : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // left
  Widget toMsgWidget({required MessageModel msg}) {
    if (msg.readAt == "") {
      BlocProvider.of<UserBloc>(context).add(
        UpdateReadStatusEvent(
          msgId: msg.msgId!,
          toId: widget.toId,
          userId: widget.userId,
        ),
      );
    }

    var sentTime = TimeOfDay.fromDateTime(
      DateTime.fromMillisecondsSinceEpoch(int.parse(msg.sentAt!)),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            margin: const EdgeInsets.all(11),
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(21),
                topRight: Radius.circular(21),
                bottomLeft: Radius.circular(21),
              ),
            ),
            child: Text(msg.msg!),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(sentTime.format(context)),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:one_chat_app/data/bloc/users/user_bloc.dart';
// import 'package:one_chat_app/data/bloc/users/user_events.dart';
// import 'package:one_chat_app/data/bloc/users/user_states.dart';
// import 'package:one_chat_app/data/firebase/firebase_provider.dart';
// import 'package:one_chat_app/domain/models/message_model.dart';
// import 'package:one_chat_app/repository/widgets/chat_page_widgets/chat_bubble.dart';
// import '../../widgets/text_feild/text_field.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({
//     super.key,
//     required this.toId,
//   });

//   final toId;

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController messageController = TextEditingController();

// //   @override
// //   void initState() {
// //     super.initState();
// //     getAllmsg();
// //   }

// //   Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getAllmsg() async {
// //     // for get all msg for bloc firebase
// //     return FirebaseProvider.getAllMsg(toId: widget.toId);
// //   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Chat page"),
//         actions: const [
//           Icon(Icons.call),
//           SizedBox(
//             width: 20,
//           ),
//           Icon(Icons.video_camera_back)
//         ],
//       ),
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.all(12),
//         child: myTextField(
//             suffIcon: IconButton(
//                 onPressed: () {
//                   BlocProvider.of<UserBloc>(context).add(SendMessageEvent(
//                     msg: messageController.text.trim(),
//                     toId: widget.toId,
//                   ));
//                 },
//                 icon: const Icon(Icons.send)),
//             hinttxt: "message a new",
//             mcrontroller: messageController,
//             labelTxt: "message"),
//       ),
//       body: ListView(
//         children: [
//           Flexible(child: BlocBuilder<UserBloc, UserStates>(
//             builder: (context, state) {
//               if (state is UserLoadingState) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (state is UserErrorState) {
//                 return Center(
//                   child: Text(state.errorMsg),
//                 );
//               } else if (state is UserLoadedState) {
//                 return StreamBuilder(
//                   stream: FirebaseProvider.getAllMsg(toId: widget.toId),
//                   builder: (context, snapshot) {
//                     return ListView.builder(
//                       itemCount: snapshot.data!.docs.length,
//                       itemBuilder: (context, index) {
//                         MessageModel eachMessage = MessageModel.fromDoc(
//                             snapshot.data!.docs[index].data());

//                         var fromId = eachMessage.fromId;

//                         if (fromId == FirebaseProvider.userId) {
//                           return ChatBubble(
//                               message: eachMessage,
//                               time: eachMessage.sentAt!,
//                               seenIcon: Icons.check,
//                               imgUrl: "",
//                               isComing: false);
//                         } else {
//                           ChatBubble(
//                               message: eachMessage,
//                               time: eachMessage.sentAt!,
//                               seenIcon: Icons.not_interested_rounded,
//                               imgUrl: "",
//                               isComing: true);
//                         }
//                       },
//                     );
//                   },
//                 );
//               }

//               return const Center(
//                 child: Text("No message"),
//               );
//             },
//           )),
//         ],
//       ),
//     );
//   }
// }
