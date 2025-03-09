part of 'register_bloc.dart';

abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {}

class ChatErrorState extends ChatState {
  String errorMsg;
  ChatErrorState({required this.errorMsg});
}
