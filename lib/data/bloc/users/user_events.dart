import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserEvents {}

class ContactsUserEvent extends UserEvents {
  List<QuerySnapshot<Map<String, dynamic>>> getUsers;

  ContactsUserEvent({required this.getUsers});
}

class GetChatIdEvent extends UserEvents {
  String fromId;
  String toId;

  GetChatIdEvent({required this.fromId, required this.toId});
}

class SendMessageEvent extends UserEvents {
  String msg;
  String toId;
  String userId;

  SendMessageEvent({
    required this.msg,
    required this.toId,
    required this.userId,
  });
}

class SendImageMsgEvent extends UserEvents {
  String imgUrl;
  String toId;
  String? imgMsg;
  String userId;

  SendImageMsgEvent(
      {required this.imgUrl,
      required this.toId,
      this.imgMsg,
      required this.userId});
}

class GetAllMsgEvent extends UserEvents {
  // String userId;
  String toId;
  String userId;

  GetAllMsgEvent({
    required this.toId,
    required this.userId,
  });
}

class UpdateReadStatusEvent extends UserEvents {
  String msgId;
  String userId;
  String toId;

  UpdateReadStatusEvent(
      {required this.msgId, required this.toId, required this.userId});
}

class GetUnreadCountEvent extends UserEvents {
  String userId;
  String toId;

  GetUnreadCountEvent({required this.userId, required this.toId});
}
