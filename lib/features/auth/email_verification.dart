import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Your Email")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.mark_email_unread, size: 80, color: Color(0xFF3A5A40)),
            const SizedBox(height: 16),
            const Text(
              "We’ve sent a verification link to your email.\nPlease check your inbox before continuing.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: Check Firebase user email verification status
              },
              child: const Text("I’ve Verified My Email"),
            ),
          ],
        ),
      ),
    );
  }
}
