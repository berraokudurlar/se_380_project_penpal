import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart';
import 'package:se_380_project_penpal/features/services/keypals_service.dart';
import 'package:se_380_project_penpal/models/user_model.dart';
import 'add_keypals_screen.dart';
import 'pending_keypals_screen.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final KeyPalsService _friendService = KeyPalsService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserModel>>(
      stream: _friendService.getFriends(),
      builder: (context, friendsSnapshot) {
        // Also listen to pending requests count
        return StreamBuilder<List>(
          stream: _friendService.getPendingRequests(),
          builder: (context, requestsSnapshot) {
            final friends = friendsSnapshot.data ?? [];
            final pendingRequests = requestsSnapshot.data?.length ?? 0;

            if (friendsSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: AppColors.textMedium),
                ),
              );
            }

            if (friends.isEmpty) {
              return _buildEmptyState(pendingRequests);
            }

            return _buildFriendsList(friends, pendingRequests);
          },
        );
      },
    );
  }

  Widget _buildEmptyState(int pendingRequests) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // REMOVED: floatingActionButton is removed here so it hides when no friends exist.
      body: SafeArea(
        child: Column(
          children: [
            if (pendingRequests > 0) _buildPendingRequestsBanner(pendingRequests),
            Expanded(
              child: Center(
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
                      'Start adding key pals that you can exchange letters with!',
                      textAlign: TextAlign.center,
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
                          MaterialPageRoute(
                            builder: (context) => const AddFriendScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.person_add, color: Colors.white),
                      label: const Text(
                        'Add Your First Key Pal',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          color: Colors.white, // Ensure text is white
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade700,
                        foregroundColor: Colors.white, // Ensure ripple/icon is white
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendsList(List<UserModel> friends, int pendingRequests) {
    // Group friends by first letter
    final groupedFriends = <String, List<UserModel>>{};
    for (var friend in friends) {
      final firstLetter = friend.displayName[0].toUpperCase();
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
            if (pendingRequests > 0) _buildPendingRequestsBanner(pendingRequests),

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
                      ...friendsInGroup.map(
                            (friend) => _buildFriendItem(context, friend),
                      ),
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
        foregroundColor: Colors.white, // Sets icon color to white
        icon: const Icon(Icons.person_add),
        label: const Text(
          'Add Key Pal',
          style: TextStyle(
            fontFamily: 'Georgia',
            color: Colors.white, // Sets text color to white
          ),
        ),
      ),
    );
  }

  Widget _buildPendingRequestsBanner(int count) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PendingKeypalsScreen(),
          ),
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
                    'You have $count pending request${count > 1 ? 's' : ''}',
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

  Widget _buildFriendItem(BuildContext context, UserModel friend) {
    return InkWell(
      onTap: () {
        _showFriendOptions(context, friend);
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
                friend.displayName[0].toUpperCase(),
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
                    '${friend.displayName} @${friend.username}',
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
                        friend.country ?? 'Location hidden',
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

  void _showFriendOptions(BuildContext context, UserModel friend) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),

            // Friend info
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.brown.shade200,
                  child: Text(
                    friend.displayName[0].toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 24,
                      color: Colors.brown.shade800,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        friend.displayName,
                        style: const TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '@${friend.username}',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 14,
                          color: Colors.brown.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Action buttons
            ListTile(
              leading: Icon(Icons.edit_note, color: Colors.brown.shade700),
              title: const Text(
                'Write a Letter',
                style: TextStyle(fontFamily: 'Georgia'),
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Writing to ${friend.displayName}...'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person_outline, color: Colors.brown.shade700),
              title: const Text(
                'View Profile',
                style: TextStyle(fontFamily: 'Georgia'),
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile view coming soon!')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_remove, color: Colors.red),
              title: const Text(
                'Remove Key Pal',
                style: TextStyle(fontFamily: 'Georgia', color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context);
                _confirmRemoveFriend(context, friend);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmRemoveFriend(BuildContext context, UserModel friend) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Remove Key Pal?',
          style: TextStyle(fontFamily: 'Georgia'),
        ),
        content: Text(
          'Are you sure you want to remove ${friend.displayName} from your Key Pals?',
          style: const TextStyle(fontFamily: 'Georgia'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.brown.shade600),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await _friendService.removeFriend(friend.userId);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Removed ${friend.displayName}'),
                      backgroundColor: Colors.orange.shade700,
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${e.toString()}'),
                      backgroundColor: Colors.red.shade700,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white, // Sets text to white
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}