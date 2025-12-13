import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart';
import 'add_keypals_screen.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  // TODO: Replace with actual Firestore data
  final List<Map<String, String>> friends = [
    {"name": "Alice", "handle": "@alice_writes", "lastLetter": "2 days ago"},
    {"name": "Ben", "handle": "@ben_letters", "lastLetter": "1 week ago"},
    {"name": "Bahar", "handle": "@rugtbly", "lastLetter": "Yesterday"},
    {"name": "Charlie", "handle": "@charlie_pen", "lastLetter": "3 days ago"},
    {"name": "Chris", "handle": "@cxskisser69", "lastLetter": "Today"},
    {"name": "Tom", "handle": "@t3baldi", "lastLetter": "5 days ago"},
  ];

  final int pendingRequests = 2; // TODO: Get from Firestore

  @override
  Widget build(BuildContext context) {
    if (friends.isEmpty) {
      return _buildEmptyState();
    }

    // Group friends by first letter
    final groupedFriends = <String, List<Map<String, String>>>{};
    for (var friend in friends) {
      final firstLetter = friend["name"]![0].toUpperCase();
      groupedFriends.putIfAbsent(firstLetter, () => []).add(friend);
    }

    // Sort the keys alphabetically
    final sortedKeys = groupedFriends.keys.toList()..sort();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pending requests banner
            if (pendingRequests > 0) _buildPendingRequestsBanner(),

            // Phonebook list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                itemCount: sortedKeys.length,
                itemBuilder: (context, index) {
                  final letter = sortedKeys[index];
                  final friendsInGroup = groupedFriends[letter]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Letter divider
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          children: [
                            Text(
                              letter,
                              style: const TextStyle(
                                fontFamily: 'Georgia',
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: AppColors.textMedium,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: AppColors.textMedium.withOpacity(0.3),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Friends in this group
                      ...friendsInGroup.map((friend) => _buildFriendItem(context, friend)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddFriendScreen()),
          );
        },
        backgroundColor: Colors.brown.shade700,
        icon: const Icon(Icons.person_add),
        label: const Text(
          'Add Key Pal',
          style: TextStyle(fontFamily: 'Georgia'),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 100,
              color: Colors.brown.shade300,
            ),
            const SizedBox(height: 24),
            const Text(
              'No Key Pals Yet',
              style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: 24,
                color: AppColors.textDark,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start adding friends to exchange letters!',
              style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: 16,
                color: Colors.brown.shade600,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddFriendScreen()),
                );
              },
              icon: const Icon(Icons.person_add),
              label: const Text(
                'Add Your First Key Pal',
                style: TextStyle(fontFamily: 'Georgia'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade700,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddFriendScreen()),
          );
        },
        backgroundColor: Colors.brown.shade700,
        icon: const Icon(Icons.person_add),
        label: const Text(
          'Add Key Pal',
          style: TextStyle(fontFamily: 'Georgia'),
        ),
      ),
    );
  }

  Widget _buildPendingRequestsBanner() {
    return InkWell(
      onTap: () {
        // TODO: Navigate to pending requests screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening friend requests...')),
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(24, 12, 24, 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.brown.shade600, Colors.brown.shade800],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.mail, color: Colors.white, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pending Requests',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'You have $pendingRequests pending request${pendingRequests > 1 ? 's' : ''}',
                    style: const TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 14,
                      color: Colors.white70,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendItem(BuildContext context, Map<String, String> friend) {
    return InkWell(
      onTap: () {
        // TODO: Navigate to friend profile
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening ${friend["name"]}\'s profile...')),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            // Profile picture
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.textMedium.withOpacity(0.2),
              child: Text(
                friend["name"]![0].toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 20,
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Name and info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${friend["name"]} ${friend["handle"]}',
                    style: const TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.mail_outline,
                        size: 14,
                        color: AppColors.textMedium,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Last letter: ${friend["lastLetter"]}',
                        style: const TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 13,
                          color: AppColors.textMedium,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Arrow icon
            const Icon(
              Icons.arrow_forward,
              color: AppColors.textMedium,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}