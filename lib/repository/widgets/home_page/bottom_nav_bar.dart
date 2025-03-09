import 'package:flutter/material.dart';
import 'package:whatsapp/repository/screens/home/chats/chats_page.dart';
import 'package:whatsapp/repository/screens/home/settings/settings.dart';

import '../../screens/home/calls/calls_page.dart';

class BottomNavBarHome extends StatefulWidget {
  const BottomNavBarHome({super.key});

  @override
  State<BottomNavBarHome> createState() => _BottomNavBarHomeState();
}

class _BottomNavBarHomeState extends State<BottomNavBarHome> {
  List<Widget> navPages = const [HomeChatsPage(), CallsPage(), SettingsPage()];

  int mSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: mSelectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            mSelectedIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.chat), label: "Chats"),
          NavigationDestination(icon: Icon(Icons.call), label: "Calls"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
      body: navPages[mSelectedIndex],
    );
  }
}
