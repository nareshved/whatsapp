class MessageModel {
  String? msgId; // prefs currTime uId loggedIn user
  String? msg;
  String? sentAt;
  String? readAt;
  String? fromId;
  String? toId;
  int? msgType; // 0 -> text  -> image
  String? imgUrl;

  MessageModel(
      {required this.msgId,
      required this.msg,
      required this.sentAt,
      this.readAt = "",
      required this.fromId,
      required this.toId,
      this.msgType = 0,
      this.imgUrl = ""});

  factory MessageModel.fromDoc(Map<String, dynamic> document) {
    return MessageModel(
      msg: document["msg"],
      sentAt: document["sentAt"],
      fromId: document["fromId"],
      toId: document["toId"],
      imgUrl: document["imgUrl"],
      msgId: document["msgId"],
      msgType: document["msgType"],
      readAt: document["readAt"],
    );
  }

  Map<String, dynamic> toDoc() {
    return {
      "msg": msg,
      "sentAt": sentAt,
      "fromId": fromId,
      "toId": toId,
      "imgUrl": imgUrl,
      "msgId": msgId,
      "msgType": msgType,
      "readAt": readAt,
    };
  }
}
