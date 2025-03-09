import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/user_model.dart';
import '../../firebase/firebase_provider.dart';
part 'register_event.dart';
part 'register_state.dart';

class ChatBloc extends Bloc<ChatEvents, ChatState> {
  FirebaseProvider firebaseProvider;

  ChatBloc({
    required this.firebaseProvider,
  }) : super(ChatInitialState()) {
    on<CreateUserOtpEvent>(
      (event, emit) async {
        emit(ChatLoadingState());

        try {
          await firebaseProvider.createUserWithOtp(
              context: event.mContext,
              mobileNo: event.mobileNo,
              verificationId: event.verificationId);

          emit(ChatLoadedState());
        } catch (e) {
          emit(ChatErrorState(errorMsg: e.toString()));
        }
      },
    );

    on<CreateUserEvent>((event, emit) async {
      emit(ChatLoadingState());

      try {
        await firebaseProvider.createUser(
          mUser: event.newUser,
          mPass: event.pass,
        );
        emit(ChatLoadedState());
      } catch (e) {
        emit(ChatErrorState(errorMsg: e.toString()));
      }
    });

    on<LoginUserEvent>((event, emit) async {
      try {
        emit(ChatLoadingState());

        await firebaseProvider.authenticateUser(
            mEmail: event.loginEmail,
            mPass: event.loginPassword,
            context: event.ctx);

        emit(ChatLoadedState());
      } catch (e) {
        emit(ChatErrorState(errorMsg: e.toString()));
        log("error loginUser event in bloc $e.toString()");
      }
    });

    // on<LogOutUserEvent>((event, emit) async {
    //   try {
    //     await FirebaseProvider.userLogOut();
    //   } catch (e) {
    //     emit(ChatErrorState(errorMsg: e.toString()));
    //     log("error user Logout event in bloc $e.toString()");
    //   }
    // });

    //  on()
  }

  //   );
  // }
}


















// on<CreateUserEvent>((event, emit) async {

    //   try {

    //   emit(RegisterLoadingState());

    //   await FirebaseProvider().createUser(event.email, event.password );

    //   emit(RegisterLoadedState());
    //   log("error msg in create user Bloc .toString()");

    //   }

    //   catch(e){

    //      emit(RegisterErrorState(errorMsg: e.toString()));

    //      log("error msg in create user Bloc $e.toString()");
    //   }
    // }
