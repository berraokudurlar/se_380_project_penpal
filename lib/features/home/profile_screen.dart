import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Profile")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/default_profile.png'), // placeholder
            ),
            SizedBox(height: 16),
            Text("Your Username", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("your.email@example.com", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 24),
            Text("Country: Hidden"),
            Text("Age: Hidden"),
          ],
        ),
      ),
    );
  }
}
