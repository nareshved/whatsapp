import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/data/firebase/firebase_provider.dart';
import 'package:whatsapp/repository/screens/auth/login_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          const ListTile(
            leading: Icon(Icons.dark_mode_rounded),
            title: Text("dark mode"),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("log out"),
            onTap: () async {
              var signOutPrefs = await SharedPreferences.getInstance();
              signOutPrefs.setString(LoginPageState.loginPrefsKey, "");

              await FirebaseProvider.logOut;

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              ).then((a) {
                log("user log out $a");
              });
            },
          ),
        ],
      ),
    );
  }
}
