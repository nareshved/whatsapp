abstract class UserStates {}

class UserInitialState extends UserStates {}

class UserLoadingState extends UserStates {}

class UserLoadedState extends UserStates {
  // Map<String, dynamic> contactUserCollection;
  // // var collection;
  // UserLoadedState({required this.contactUserCollection});
}

class UserErrorState extends UserStates {
  String errorMsg;
  UserErrorState({required this.errorMsg});
}
