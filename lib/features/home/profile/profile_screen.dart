import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart';
import '../../services/user_service.dart';
import 'edit_profile_screen.dart';
import '../../../models/user_model.dart';








class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;

  String displayName = "";
  String username = "";
  String bio = "";
  String status = "Offline";
  String country = "Hidden";
  String age = "Hidden";

  List<String> interests = [];
  List<Map<String, String>> languages = [];

  int sentCount = 0;
  int receivedCount = 0;
  int friendsCount = 0;

  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user = await _userService.getCurrentUser();

      if (user == null) {
        setState(() => isLoading = false);
        return;
      }

      setState(() {
        displayName = user.displayName;
        username = user.username;
        bio = user.bio ?? "";

        country = (user.isCountryPublic ?? false)
            ? (user.country ?? "Unknown")
            : "Hidden";

        age = (user.isAgePublic ?? false && user.age != null)
            ? user.age.toString()
            : "Hidden";

        interests = user.interests ?? [];

        languages = user.languages ?? [];
        sentCount = user.lettersSent?.length ?? 0;
        receivedCount = user.lettersReceived?.length ?? 0;
        friendsCount = user.friends?.length ?? 0;

        status = "Online";
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Profile load error: $e");
      setState(() => isLoading = false);
    }
  }



  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildProfileHeader(),
                  const SizedBox(height: 24),
                  _buildBioCard(),
                  const SizedBox(height: 16),
                  _buildStatsCard(),
                  const SizedBox(height: 16),
                  _buildInterestsCard(),
                  const SizedBox(height: 16),
                  _buildDetailsCard(),
                  const SizedBox(height: 16),
                  _buildLanguagesCard(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile picture with status indicator
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.brown.shade400,
                    width: 3,
                  ),
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.brown.shade200,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.brown.shade600,
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: _getStatusColor(status),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Name
          Text(
            displayName,
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),

          // Username
          Text(
            "@$username",
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 16,
              color: Colors.brown.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBioCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_stories, color: Colors.brown.shade700, size: 20),
              const SizedBox(width: 8),
              Text(
                "About Me",
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            bio,
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontSize: 15,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              Icons.send_outlined,
              sentCount.toString(),
              "Sent",
            ),
          ),
          Container(
            width: 1,
            height: 50,
            color: Colors.brown.shade200,
          ),
          Expanded(
            child: _buildStatItem(
              Icons.mail_outline,
              receivedCount.toString(),
              "Received",
            ),
          ),
          Container(
            width: 1,
            height: 50,
            color: Colors.brown.shade200,
          ),
          Expanded(
            child: _buildStatItem(
              Icons.people_outline,
              friendsCount.toString(),
              "Key Pals",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String count, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.brown.shade700, size: 28),
        const SizedBox(height: 8),
        Text(
          count,
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.brown.shade900,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 13,
            color: Colors.brown.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildInterestsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.favorite_outline, color: Colors.brown.shade700, size: 20),
              const SizedBox(width: 8),
              Text(
                "Interests",
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: interests.map((interest) => _buildInterestTag(interest)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestTag(String interest) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.brown.shade100,
            Colors.brown.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.brown.shade300, width: 1.5),
      ),
      child: Text(
        interest,
        style: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.brown.shade800,
        ),
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.brown.shade700, size: 20),
              const SizedBox(width: 8),
              Text(
                "Details",
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDetailRow(Icons.public, "Country", country),
          const SizedBox(height: 12),
          _buildDetailRow(Icons.cake_outlined, "Age", age),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.brown.shade600, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 13,
                  color: Colors.brown.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLanguagesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.language, color: Colors.brown.shade700, size: 20),
              const SizedBox(width: 8),
              Text(
                "Languages",
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...languages.asMap().entries.map((entry) {
            int index = entry.key;
            var lang = entry.value;
            Color chipColor = index == 0
                ? Colors.green.shade100
                : index == 1
                ? Colors.orange.shade100
                : Colors.blue.shade100;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildLanguageChip(lang["language"]!, lang["level"]!, chipColor),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildLanguageChip(
      String language,
      String level,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.brown.shade200),
      ),
      child: Row(
        children: [
          // Language text (overflow-safe)
          Expanded(
            child: Text(
              language,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Georgia',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          if (level.isNotEmpty) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.brown.shade300),
              ),
              child: Text(
                level,
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.brown.shade800,
                ),
              ),
            ),
          ],
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
}