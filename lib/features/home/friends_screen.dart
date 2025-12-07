import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data - replace with your actual data
    final friends = <Map<String, String>>[
      {"name": "Alice", "handle": "@alice_writes", "lastLetter": "2 days ago"},
      {"name": "Ben", "handle": "@ben_letters", "lastLetter": "1 week ago"},
      {"name": "Bahar", "handle": "@rugtbly", "lastLetter": "Yesterday"},
      {"name": "Charlie", "handle": "@charlie_pen", "lastLetter": "3 days ago"},
      {"name": "Chris", "handle": "@cxskisser69", "lastLetter": "Today"},
      {"name": "Tom", "handle": "@t3baldi", "lastLetter": "5 days ago"},
    ];

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
    );
  }

  Widget _buildFriendItem(BuildContext context, Map<String, String> friend) {
    return InkWell(
      onTap: () {
        // Navigate to friend profile or write letter
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