import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/features/home/home_screen.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final countryController = TextEditingController();
    final bioController = TextEditingController();
    final displayNameController = TextEditingController();
    final ageController = TextEditingController();
    final interestsController = TextEditingController();
    final languageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Set Up Your Profile")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.person, size: 90, color: Color(0xFF6B4423)),
            const SizedBox(height: 16),
            TextField(
              controller: countryController,
              decoration: const InputDecoration(labelText: "Country"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bioController,
              decoration: const InputDecoration(labelText: "Short Bio (optional)"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: save to Firestore
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
