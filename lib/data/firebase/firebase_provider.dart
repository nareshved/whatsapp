import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/repository/screens/auth/login_page.dart';
import 'package:whatsapp/repository/screens/auth/otp_verification.dart';
import 'package:whatsapp/repository/widgets/home_page/bottom_nav_bar.dart';
import '../../domain/models/message_model.dart';
import '../../domain/models/user_model.dart';

class FirebaseProvider {
  static final firebaseAuth = FirebaseAuth.instance;
  static final firebaseFireStore = FirebaseFirestore.instance;

  static const String collectionUser = "users";
  static const String collectionChat = "chats";
  static const String collectionMSG = "messages";

  //   static final userId = firebaseAuth.currentUser!.uid;
  static final userId = FirebaseAuth.instance.currentUser!.uid;
  static final logOut = FirebaseAuth.instance.signOut();

  Future<void> createUserWithOtp({
    required String mobileNo,
    String? verificationId,
    required BuildContext context,
  }) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91$mobileNo",
        verificationCompleted: (phoneAuthCredential) {
          log("verificationCompleted");
        },
        verificationFailed: (error) {
          log("verificationFailed");
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      OtpVerificationPage(mVerificationId: verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {
          log("verificationId");
        },
      );
    } catch (e) {
      log("new error found in otp firebase ${e.toString()}");
    }
  }

  Future<void> createUser({
    required UserModel mUser,
    required String mPass,
  }) async {
    try {
      UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: mUser.email!, password: mPass);

      /// create user in firestore
      if (credential.user != null) {
        firebaseFireStore
            .collection(collectionUser)
            .doc(credential.user!.uid)
            .set(mUser.toDoc())
            .then((value) {})
            .onError((error, stackTrace) {
              log("Error: $error");
              throw Exception("Error: $error");
            });
      }
    } on FirebaseException catch (e) {
      log("Error: $e");

      if (e.code == 'weak-password') {
        throw Exception("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        throw Exception("The account already exists for that email");
      }

      // throw Exception("Error: $e");
    }
  }

  Future<void> authenticateUser({
    required mEmail,
    required String mPass,
    required BuildContext context,
  }) async {
    try {
      final UserCredential credential = await firebaseAuth
          .signInWithEmailAndPassword(email: mEmail, password: mPass);

      if (credential.user != null) {
        var prefs = await SharedPreferences.getInstance();
        prefs.setString(LoginPageState.loginPrefsKey, credential.user!.uid);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavBarHome()),
        );
      }
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        throw Exception("Wrong password provided for that user.");
      }

      throw Exception("Wrong Email or password please check");
    } catch (e) {
      log("user login failed error ${e.toString()}");
    }
  }

  /// fetch all contacts from firebase
  static Future<QuerySnapshot<Map<String, dynamic>>>
  getAllContactsFirebase() async {
    return firebaseFireStore.collection(collectionUser).get();
  }

  // static userLogOut() async {
  //   await firebaseAuth.signOut();

  //   PrefsUser().mShowSnackBar("You are signOut");

  //   log("user signOut from firebase");

  //   PrefsUser.prefsSetlogOut(value: "");

  //   log("user signOut from prefs");

  // }
  // static Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
  //   return fireBaseFireStore.collection(COLLECTION_USER).get();
  // }

  static String getChatId(String fromId, String toId) {
    log("$fromId, $toId");
    if (fromId.hashCode <= toId.hashCode) {
      return "${fromId}_$toId";
    } else {
      return "${toId}_$fromId";
    }
  }

  static Future<void> sendMessage({
    required String msg,
    required String toId,
    required String userId,
  }) async {
    var currTime = DateTime.now().millisecondsSinceEpoch;
    var chatId = getChatId(userId, toId);
    log("$userId, $toId");
    log(chatId);

    var newMsg = MessageModel(
      msgId: currTime.toString(),
      msg: msg,
      sentAt: currTime.toString(),
      fromId: userId,
      toId: toId,
    );

    firebaseFireStore
        .collection(collectionChat)
        .doc(chatId)
        .collection(collectionMSG)
        .doc(currTime.toString())
        .set(newMsg.toDoc());
  }
  //   static Future<void> sendMessage(
  //       {required String msg,
  //       required String toId,
  //       required String userId}) async {
  //     var currTime = DateTime.now().millisecondsSinceEpoch;
  //     var chatId = await getChatId(userId, toId);
  //     log("$userId, $toId");
  //     log(chatId);

  //     var newMsg = MessageModel(
  //         msgId: currTime.toString(),
  //         msg: msg,
  //         sentAt: currTime.toString(),
  //         fromId: userId,
  //         toId: toId);

  //     firebaseFireStore
  //         .collection(collectionChat)
  //         .doc(chatId)
  //         .collection(collectionMSG)
  //         .doc(currTime.toString())
  //         .set(newMsg.toDoc());
  //   }

  static Future<void> sendImageMsg({
    required String imgUrl,
    required String toId,
    String imgMsg = "",
    required String userId,
  }) async {
    var currTime = DateTime.now().millisecondsSinceEpoch;
    var chatId = getChatId(userId, toId);

    var newImgMsg = MessageModel(
      msgId: currTime.toString(),
      msg: imgMsg,
      sentAt: currTime.toString(),
      fromId: userId,
      msgType: 1,
      imgUrl: imgUrl,
      toId: toId,
    );

    firebaseFireStore
        .collection(collectionChat)
        .doc(chatId)
        .collection(collectionMSG)
        .doc(currTime.toString())
        .set(newImgMsg.toDoc());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMsg({
    required String toId,
    required String userId,
  }) {
    var chatId = getChatId(userId, toId);
    log("getMessage : $userId, $toId");
    log("getMessage : $chatId");

    return firebaseFireStore
        .collection(collectionChat)
        .doc(chatId)
        .collection(collectionMSG)
        // .orderBy("sentAt", descending: true) /// for scroll controller
        .snapshots();
  }

  static Future<void> updateReadStatus({
    required String mId,
    required String userId,
    required String toId,
  }) async {
    var currTime = DateTime.now().millisecondsSinceEpoch;
    var chatId = getChatId(userId, toId);

    return await firebaseFireStore
        .collection(collectionChat)
        .doc(chatId)
        .collection(collectionMSG)
        .doc(mId)
        .update({"readAt": currTime.toString()});
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUnreadCount({
    required String userId,
    required String toId,
  }) {
    var chatId = getChatId(userId, toId);

    return firebaseFireStore
        .collection(collectionChat)
        .doc(chatId)
        .collection(collectionMSG)
        .where("readAt", isEqualTo: "")
        .where("fromId", isEqualTo: toId)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMsg({
    required String userId,
    required String toId,
  }) {
    var chatId = getChatId(userId, toId);

    return firebaseFireStore
        .collection(collectionChat)
        .doc(chatId)
        .collection(collectionMSG)
        .orderBy("sentAt", descending: true)
        .limit(1)
        .snapshots();
  }
}
