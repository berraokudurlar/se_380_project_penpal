import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/features/auth/profile_setup.dart';
import '../home/profile/edit_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isChecking = false;
  bool isResending = false;


  Future<void> checkVerification() async {
    setState(() {
      isChecking = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("User not logged in");
      }

      await user.reload();
      final refreshedUser = FirebaseAuth.instance.currentUser;

      if (refreshedUser != null && refreshedUser.emailVerified) {
        // update Firestore AFTER verification
        await FirebaseFirestore.instance
            .collection('users')
            .doc(refreshedUser.uid)
            .update({
          "isVerified": true,
        });

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => EditProfileScreen(
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Your email is not verified yet. Please check your inbox and try again.",
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error checking verification status: $e"),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isChecking = false;
        });
      }
    }
  }

  Future<void> resendVerificationEmail() async {
    setState(() {
      isResending = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("User not logged in");
      }

      await user.sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Verification email sent again."),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to resend email: $e"),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isResending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Your Email"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Transform.translate(
          offset: const Offset(0, -40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.mark_email_unread,
                size: 90,
                color: Color(0xFF6B4423),
              ),
              const SizedBox(height: 16),

              const Text(
                "We’ve sent a verification link to your email address.\n"
                    "Please verify your email before continuing.",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isChecking ? null : checkVerification,
                  child: isChecking
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Text("I’ve Verified My Email"),
                ),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: isResending ? null : resendVerificationEmail,
                child: isResending
                    ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : const Text("Resend verification email"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
