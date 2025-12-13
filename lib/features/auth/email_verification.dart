import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/features/auth/profile_setup.dart';

import '../home/profile/edit_profile_screen.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Your Email")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Transform.translate(
          offset: const Offset(0, -50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.mark_email_unread, size: 90, color: Color(0xFF6B4423)),
            const SizedBox(height: 16),
            const Text(
              "We’ve sent a verification link to your email.\nPlease check your inbox before continuing.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 27),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Check Firebase user email verification status
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => EditProfileScreen(
                      displayName: "",
                      username: "",
                      bio: "",
                      status: "Online",
                      country: "",
                      age: "",
                      interests: [],
                      languages: [],
                      isFirstSetup: true,

                    ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 14),
                  child: const Text("I’ve Verified My Email"),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
