class UserModel {
  String? userId;
  String? name;
  String? email;
  String? mobNo;
  String? gender;
  bool isOnline = false;
  int? status = 1; //1-> Active, 2->inActive, 3->Suspended
  String? profilePic = "";
  int? profileStatus = 1;

  UserModel(
      {this.userId,
      required this.name,
      required this.email,
      required this.mobNo,
      required this.gender,
      required this.isOnline,
      required this.status,
      required this.profilePic,
      required this.profileStatus}); //1-> public, 2->private, 3->onlyFriends

  factory UserModel.fromDoc(Map<String, dynamic> document) {
    return UserModel(
      name: document['name'],
      email: document['email'],
      mobNo: document['mobNo'],
      gender: document['gender'],
      isOnline: document['isOnline'],
      status: document['status'],
      profilePic: document['profilePic'],
      profileStatus: document['profileStatus'],
    );
  }

  Map<String, dynamic> toDoc() => {
        "name": name,
        "email": email,
        "mobNo": mobNo,
        "gender": gender,
        "isOnline": isOnline,
        "status": status,
        "profilePic": profilePic,
        "profileStatus": profileStatus,
      };
}
