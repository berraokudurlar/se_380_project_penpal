import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final friends = <String>["Alice", "Ben", "Charlie"]; // placeholder

    return Scaffold(
      appBar: AppBar(title: const Text("Your Friends")),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(friends[index]),
            trailing: IconButton(
              icon: const Icon(Icons.mail_outline),
              onPressed: () {
                // TODO: open Send Letter
              },
            ),
          );
        },
      ),
    );
  }
}
