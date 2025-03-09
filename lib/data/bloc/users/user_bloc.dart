import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../firebase/firebase_provider.dart';
import 'user_events.dart';
import 'user_states.dart';

class UserBloc extends Bloc<UserEvents, UserStates> {
  FirebaseProvider firebaseProvider;

  UserBloc({
    required this.firebaseProvider,
  }) : super(UserInitialState()) {
    // on<ContactsUserEvent>((event, emit) async {
    //   emit(UserLoadingState());
    //
    //   try {
    //     List<> contacts = await FirebaseProvider.getAllContactsFirebase();
    //
    //     emit(UserLoadedState(
    //         contactUserCollection: event.);
    //   } catch (e) {
    //     emit(UserErrorState(errorMsg: e.toString()));
    //   }
    // });

    on<GetChatIdEvent>(
      (event, emit) {
        emit(UserLoadingState());
        try {
          FirebaseProvider.getChatId(event.fromId, event.toId);
          emit(UserLoadedState());
        } catch (e) {
          emit(UserErrorState(errorMsg: e.toString()));

          log("error found in user bloc getChatId${e.toString()}");
        }
      },
    );

    on<SendMessageEvent>(
      (event, emit) async {
        emit(UserLoadingState());
        try {
          await FirebaseProvider.sendMessage(
            userId: event.userId,
            msg: event.msg,
            toId: event.toId,
          );

          emit(UserLoadedState());
        } catch (e) {
          emit(UserErrorState(errorMsg: e.toString()));
          log("error in user bloc SendMessageEvent${e.toString()}");
        }
      },
    );

    on<SendImageMsgEvent>(
      (event, emit) async {
        emit(UserLoadingState());
        try {
          await FirebaseProvider.sendImageMsg(
              imgUrl: event.imgUrl, toId: event.toId, userId: event.userId);

          emit(UserLoadedState());
        } catch (e) {
          emit(UserErrorState(errorMsg: e.toString()));
          log("error in user bloc SendImageMsgEvent${e.toString()}");
        }
      },
    );

    on<GetAllMsgEvent>(
      (event, emit) {
        emit(UserLoadingState());
        try {
          FirebaseProvider.getAllMsg(
            userId: event.userId,
            toId: event.toId,
          );

          emit(UserLoadedState());
        } catch (e) {
          emit(UserErrorState(errorMsg: e.toString()));
          log("errror in user bloc getAllMsg ${e.toString()}");
        }
      },
    );

    on<UpdateReadStatusEvent>(
      (event, emit) async {
        emit(UserLoadingState());

        try {
          await FirebaseProvider.updateReadStatus(
              mId: event.msgId, userId: event.userId, toId: event.toId);

          emit(UserLoadedState());
        } catch (e) {
          emit(UserErrorState(errorMsg: e.toString()));
          log("error in UpdateReadStatusEvent in bloc ${e.toString()}");
        }
      },
    );

    on<GetUnreadCountEvent>(
      (event, emit) {
        emit(UserLoadingState());

        try {
          FirebaseProvider.getUnreadCount(
              userId: event.userId, toId: event.toId);

          emit(UserLoadedState());
        } catch (e) {
          emit(UserErrorState(errorMsg: e.toString()));
          log("error in GetUnreadCountEvent ${e.toString()}");
        }
      },
    );
  }
}
