import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart';
import 'edit_profile_screen.dart';
import '../../../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


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

  @override
  void initState() {
    super.initState();
    _loadUserFromFirestore();
  }

  Future<void> _loadUserFromFirestore() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        setState(() => isLoading = false);
        return;
      }

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (!doc.exists) {
        setState(() => isLoading = false);
        return;
      }

      final model = UserModel.fromJson(doc.data()!);

      setState(() {
        displayName = model.displayName;
        username = model.username;
        bio = model.bio ?? "";

        country = (model.isCountryPublic ?? false)
            ? (model.country ?? "Unknown")
            : "Hidden";

        age = (model.isAgePublic ?? false && model.age != null)
            ? model.age.toString()
            : "Hidden";

        interests = model.interests ?? [];

        languages = (model.languages ?? [])
            .map((lang) => {
          "language": lang,
          "level": "",
        })
            .toList();

        sentCount = model.lettersSent?.length ?? 0;
        receivedCount = model.lettersReceived?.length ?? 0;
        friendsCount = model.friends?.length ?? 0;

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
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 80,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                            displayName: displayName,
                            username: username,
                            bio: bio,
                            status: status,
                            country: country,
                            age: age,
                            interests: interests,
                            languages: languages,
                          ),
                        ),
                      );

                      if (result != null) {
                        setState(() {
                          displayName = result['displayName'] ?? displayName;
                          username = result['username'] ?? username;
                          bio = result['bio'] ?? bio;
                          status = result['status'] ?? status;
                          country = result['country'] ?? country;
                          age = result['age'] ?? age;
                          interests =
                          List<String>.from(result['interests'] ?? interests);
                          languages = List<Map<String, String>>.from(
                            (result['languages'] as List)
                                .map((e) => Map<String, String>.from(e)),
                          );
                        });
                      }
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.brown.shade600,
                            Colors.brown.shade800,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.brown.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Edit',
                            style: TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Profile content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Profile Picture Card
                  _buildProfileHeader(),
                  const SizedBox(height: 24),

                  // Bio Card
                  _buildBioCard(),
                  const SizedBox(height: 16),

                  // Stats Card
                  _buildStatsCard(),
                  const SizedBox(height: 16),

                  // Interests Section
                  _buildInterestsCard(),
                  const SizedBox(height: 16),

                  // Details Card
                  _buildDetailsCard(),
                  const SizedBox(height: 16),

                  // Languages Card
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