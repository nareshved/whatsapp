import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsUser {
  late BuildContext ctx;

  static const String prefsloginString = "userUidFirebaseKey";

  static const String prefsLoginBool = "boolKey";

  static const String prefsLogOut = "logOut";

  /// snackbar show
  ///
  void mShowSnackBar(String message) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message)));
  }

  // set for prefs

  static Future prefsUserUidString({required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(prefsloginString, value);
  }

  static Future prefsSetBool({required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(prefsLoginBool, value);
  }

  static Future prefsSetlogOut({required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(prefsLogOut, value);
  }

  // get from prefs

  static Future prefsGetUserUidString(String prefsloginString,
      {required String? myKey}) async {
    final prefs = await SharedPreferences.getInstance();
    myKey = prefs.getString(
      prefsloginString,
    );
  }

  static Future prefsGetBool() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getBool(prefsLoginBool);
  }

  static Future prefsGetlogOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString(prefsLogOut);
  }
}
