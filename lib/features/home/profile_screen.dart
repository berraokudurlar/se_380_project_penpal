import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart';
import 'edit_profile_screen.dart'; // make sure this file exists

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final String status = "Online"; // Example: Online, Busy, Offline

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accentLight,
      body: SafeArea(
        child: Stack(
          children: [
            // Main profile content
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: _buildProfileCard(),
              ),
            ),

            // Floating edit button
            Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.edit, color: AppColors.textDark, size: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border.withOpacity(0.7),
          width: 1.3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile picture + status
          Stack(
            children: [
              const CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage('assets/default_profile.png'),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: _getStatusColor(status),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          const Text(
            "Display Name",
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "@username",
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 16,
              color: AppColors.textMedium,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "This is the user's bio. It can be a few lines describing the user, their interests, or anything they want to share.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 16,
              color: AppColors.textMedium,
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            "Profile Details",
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),

          _infoRow("Country", "Hidden"),
          _infoRow("Age", "Hidden"),
          _infoRow("Interests", "Reading, Music, Coding"),
          const SizedBox(height: 12),

          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Languages:",
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 6),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(2),
                  },
                  border: TableBorder.all(
                    color: AppColors.border.withOpacity(0.5),
                    width: 1,
                  ),
                  children: const [
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("English", style: TextStyle(color: AppColors.textMedium)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Fluent", style: TextStyle(color: AppColors.textMedium)),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Turkish", style: TextStyle(color: AppColors.textMedium)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Intermediate", style: TextStyle(color: AppColors.textMedium)),
                      ),
                    ]),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          _infoRow("Letters Sent", "0"),
          _infoRow("Letters Received", "0"),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Online":
        return Colors.green;
      case "Busy":
        return Colors.orange;
      case "Offline":
      default:
        return Colors.grey;
    }
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontSize: 16,
              color: AppColors.textDark,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Georgia',
              color: AppColors.textMedium,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
