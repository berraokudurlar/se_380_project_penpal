import 'package:flutter/material.dart';

class LetterboxScreen extends StatelessWidget {
  const LetterboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final letters = <String>[]; // will come from provider later

    return Scaffold(
      appBar: AppBar(title: const Text("Your Mailbox")),
      body: letters.isEmpty
          ? const Center(
        child: Text("📭 No letters yet.\nWrite to your penpal!", textAlign: TextAlign.center),
      )
          : ListView.builder(
        itemCount: letters.length,
        itemBuilder: (context, index) {
          final letter = letters[index];
          return ListTile(
            leading: const Icon(Icons.mail_outline),
            title: Text(letter),
            onTap: () {
              // TODO: open letter detail
            },
          );
        },
      ),
    );
  }
}
