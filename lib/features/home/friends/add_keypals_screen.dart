import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart';
import 'package:se_380_project_penpal/features/services/keypals_service.dart';
import 'package:se_380_project_penpal/models/user_model.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final TextEditingController searchController = TextEditingController();
  final KeyPalsService _friendService = KeyPalsService();

  List<UserModel> searchResults = [];
  Map<String, String> friendshipStatuses = {}; // userId -> status
  bool isSearching = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _searchUsers() async {
    final query = searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      isSearching = true;
      searchResults = [];
      friendshipStatuses = {};
    });

    try {
      final results = await _friendService.searchUsers(query);

      // Get friendship status for each result
      for (var user in results) {
        final status = await _friendService.getFriendshipStatus(user.userId);
        friendshipStatuses[user.userId] = status;
      }

      if (mounted) {
        setState(() {
          searchResults = results;
          isSearching = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isSearching = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Search failed: $e"),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    }
  }

  Future<void> _sendFriendRequest(UserModel user) async {
    try {
      await _friendService.sendFriendRequest(user.userId);

      // Update status
      setState(() {
        friendshipStatuses[user.userId] = 'request_sent';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Key Pal request sent to ${user.displayName}! 📬"),
            backgroundColor: Colors.green.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Add Key Pal',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 24,
            color: AppColors.textDark,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              // --- UPDATED: Removed BoxDecoration ---
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.brown.shade600),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: const TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 16,
                        color: AppColors.textDark, // Ensure text is visible
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search by username...',
                        hintStyle: TextStyle(
                          fontFamily: 'Georgia',
                          color: Colors.brown.shade400,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _searchUsers(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.brown.shade600),
                    onPressed: _searchUsers,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Search results
            if (isSearching)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.textMedium,
                  ),
                ),
              )
            else if (searchResults.isEmpty && searchController.text.isNotEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_search,
                        size: 80,
                        color: Colors.brown.shade300,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No users found',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 18,
                          color: Colors.brown.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else if (searchResults.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 80,
                          color: Colors.brown.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Search for Key Pals',
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 18,
                            color: Colors.brown.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Enter a username to find people to exchange letters with.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 14,
                            color: Colors.brown.shade400,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final user = searchResults[index];
                      final status = friendshipStatuses[user.userId] ?? 'loading';
                      return _buildUserCard(user, status);
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(UserModel user, String friendshipStatus) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.brown.shade200,
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.brown.shade600,
                ),
              ),
              const SizedBox(width: 16),

              // User info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName,
                      style: const TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '@${user.username}',
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 14,
                        color: Colors.brown.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    if (user.country != null && user.country!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.public, size: 14, color: Colors.brown.shade500),
                          const SizedBox(width: 4),
                          Text(
                            user.country!,
                            style: TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 13,
                              color: Colors.brown.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          if (user.bio != null && user.bio!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              user.bio!,
              style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: 14,
                color: Colors.brown.shade700,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],

          // Interests
          if (user.interests != null && user.interests!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: (user.interests!).take(3).map((interest) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.brown.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.brown.shade300),
                  ),
                  child: Text(
                    interest,
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 12,
                      color: Colors.brown.shade700,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],

          const SizedBox(height: 16),

          // Action buttons based on friendship status
          _buildActionButtons(user, friendshipStatus),
        ],
      ),
    );
  }

  Widget _buildActionButtons(UserModel user, String status) {
    switch (status) {
      case 'friends':
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 18, color: Colors.green.shade700),
              const SizedBox(width: 8),
              Text(
                'Already Key Pals',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );

      case 'request_sent':
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.schedule, size: 18, color: Colors.orange.shade700),
              const SizedBox(width: 8),
              Text(
                'Request Sent',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  color: Colors.orange.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );

      case 'request_received':
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mail, size: 18, color: Colors.blue.shade700),
              const SizedBox(width: 8),
              Text(
                'Check Pending Requests',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );

      case 'not_friends':
      default:
        return Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile view coming soon!')),
                  );
                },
                icon: const Icon(Icons.person_outline, size: 18),
                label: const Text(
                  'View Profile',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade400,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _sendFriendRequest(user),
                icon: const Icon(Icons.person_add, size: 18),
                label: const Text(
                  'Add Key Pal',
                  style: TextStyle(fontFamily: 'Georgia'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        );
    }
  }
}