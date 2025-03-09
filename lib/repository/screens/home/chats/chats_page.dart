import 'package:flutter/material.dart';
import 'package:whatsapp/repository/screens/pages/contact_page.dart';

class HomeChatsPage extends StatelessWidget {
  const HomeChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chats")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactPage()),
          );
        },
        child: const Icon(Icons.add_comment_sharp),
      ),
    );
  }
}
