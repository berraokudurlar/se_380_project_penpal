import 'package:flutter/material.dart';

class WriteLetterScreen extends StatelessWidget {
  const WriteLetterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final toController = TextEditingController();
    final contentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Write a Letter")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: toController,
              decoration: const InputDecoration(labelText: "To (username)"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contentController,
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: "Your Letter",
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: save to Firestore, send to receiver
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Letter sent!")),
                );
                Navigator.pop(context);
              },
              child: const Text("Send Letter"),
            ),
          ],
        ),
      ),
    );
  }
}
