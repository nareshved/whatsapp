part of 'register_bloc.dart';

abstract class ChatEvents {}

class CreateUserEvent extends ChatEvents {
  UserModel newUser;
  String pass;
  CreateUserEvent({required this.newUser, required this.pass});
}

class LoginUserEvent extends ChatEvents {
  String loginEmail;
  String loginPassword;
  BuildContext ctx;

  LoginUserEvent(
      {required this.loginEmail,
      required this.loginPassword,
      required this.ctx});
}

class LogOutUserEvent extends ChatEvents {}

class CreateUserOtpEvent extends ChatEvents {
  final String mobileNo;
  final String? verificationId;
  final BuildContext mContext;

  CreateUserOtpEvent(
      {required this.mobileNo, this.verificationId, required this.mContext});
}
