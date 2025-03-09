import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/data/firebase/firebase_provider.dart';
import 'package:whatsapp/domain/models/message_model.dart';
import 'package:whatsapp/domain/models/user_model.dart';
import 'package:whatsapp/repository/screens/auth/login_page.dart';
import 'package:whatsapp/repository/screens/pages/chat_page.dart';

class ContactPage extends StatelessWidget {
  ContactPage({super.key});

  var userId;

  Future<void> getUserIdPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(LoginPageState.loginPrefsKey);
  }

  @override
  Widget build(BuildContext context) {
    getUserIdPrefs();
    return Scaffold(
      appBar: AppBar(title: const Text("Contacts")),
      body: SafeArea(
        child: FutureBuilder(
          future: FirebaseProvider.getAllContactsFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              //   } else if (!snapshot.hasData || snapshot.data == null) {
              //     // Handle the case when there's no data
              //     return const Center(
              //       child: Text('No Contacts Found'),
              //     );
            }

            List<UserModel> arrUsers = [];

            for (QueryDocumentSnapshot<Map<String, dynamic>> eachDoc
                in snapshot.data!.docs) {
              var eachUser = UserModel.fromDoc(eachDoc.data());

              if (eachDoc.id != userId) {
                eachUser.userId = eachDoc.id;
                arrUsers.add(eachUser);
              }
            }

            return snapshot.data!.docs.isNotEmpty
                ? ListView.builder(
                  itemCount: arrUsers.length,
                  itemBuilder: (context, index) {
                    // var eachContactId = snapshot.data!.docs[index].id;
                    var eachContactId = arrUsers[index].userId;
                    return StreamBuilder(
                      stream: FirebaseProvider.getUnreadCount(
                        userId: userId,
                        toId: eachContactId!,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }
                        }

                        if (snapshot.hasData) {
                          return ListTile(
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ChatPage(
                                          toId: eachContactId,
                                          userId: userId,
                                        ),
                                  ),
                                ),
                            title: Text(arrUsers[index].name!),
                            subtitle: getLastMsg(toId: userId),
                            trailing: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "${snapshot.data!.docs.length}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    );
                  },
                )
                : const Center(child: Text('No Contacts Found'));
          },
        ),
      ),
    );
  }

  StreamBuilder getLastMsg({
    required String toId,
    String subtitle = "no last message",
  }) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseProvider.getLastMsg(userId: userId, toId: toId),
      builder: (context, snapshot) {
        // var sentTime = TimeOfDay.fromDateTime(
        //     DateTime.fromMillisecondsSinceEpoch(int.parse()));

        if (snapshot.hasData) {
          if (snapshot.data!.docs.isNotEmpty) {
            var messageModel = MessageModel.fromDoc(
              snapshot.data!.docs[0].data(),
            ); // for who are sent last message by check by userID
            var lastMsg = messageModel.msg;
            //var lastMsg = MessageModel.fromDoc(snapshot.data!.docs[0].data()).msg;

            if (messageModel.fromId == userId) {
              /// if lastMsg from me
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.done_all_outlined,
                    color:
                        messageModel.readAt != "" ? Colors.blue : Colors.grey,
                  ),
                  Text(lastMsg!),
                ],
              );
            } else {
              /// if last message to Id!
              return Text(lastMsg!);
            }
          } else {
            return Text(subtitle);
          }
        } else {
          return Text(subtitle);
        }
        //   return Container();
      },
    );
  }
}

// ListTile(
//                       onTap: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ChatPage(
//                               toId: eachContactId,
//                               userId: userId,
//                             ),
//                           )),
//                       title: Text(arrUsers[index].name!),
//                       subtitle: Text(arrUsers[index].email!),
//                     );
