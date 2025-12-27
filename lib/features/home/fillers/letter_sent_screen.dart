import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/features/home/home_screen.dart';
import 'package:lottie/lottie.dart';

class LetterSentScreen extends StatefulWidget {
  final String recipientName;

  const LetterSentScreen({
    super.key,
    required this.recipientName,
  });

  @override
  State<LetterSentScreen> createState() => _LetterSentScreenState();
}

class _LetterSentScreenState extends State<LetterSentScreen> {
  @override
  void initState() {
    super.initState();
    // Auto-redirect to home screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6E4),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Success checkmark emoji
                Lottie.asset(
                  'assets/images_animations/Emailsuccessfullysent.json',
                  width: 200,
                  height: 200,
                  repeat: false,
                ),

                const SizedBox(height: 40),

                // Success message
                Text(
                  'Letter Sent Successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade800,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 20),

                // Recipient info
                Text(
                  'Your letter is on its way to ${widget.recipientName}...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 18,
                    color: Colors.brown.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 60),

                // Manual navigation button
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  },
                  child: Text(
                    'Redirecting to your letterbox...',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 16,
                      color: Colors.brown.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}