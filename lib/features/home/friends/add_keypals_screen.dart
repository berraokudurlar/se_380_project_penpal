import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
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
    });

    // TODO: Replace with actual Firestore search
    // QuerySnapshot results = await FirebaseFirestore.instance
    //   .collection('users')
    //   .where('username', isGreaterThanOrEqualTo: query)
    //   .where('username', isLessThanOrEqualTo: query + '\uf8ff')
    //   .get();

    // Simulated search results for now
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      searchResults = [
        {
          'userId': '1',
          'username': 'bookworm_jane',
          'displayName': 'Jane Smith',
          'bio': 'Love reading classic novels and drinking tea',
          'country': 'UK',
          'interests': ['Reading', 'Tea', 'Writing'],
        },
        {
          'userId': '2',
          'username': 'traveler_tom',
          'displayName': 'Tom Wilson',
          'bio': 'Exploring the world one letter at a time',
          'country': 'USA',
          'interests': ['Traveling', 'Photography'],
        },
      ];
      isSearching = false;
    });
  }

  void _sendFriendRequest(Map<String, dynamic> user) async {
    // TODO: Send friend request to Firestore
    // await FirebaseFirestore.instance.collection('friendRequests').add({
    //   'from': currentUserId,
    //   'to': user['userId'],
    //   'status': 'pending',
    //   'createdAt': FieldValue.serverTimestamp(),
    // });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Key Pal request sent to ${user['displayName']}! 📬"),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.brown.shade300, width: 1.5),
              ),
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
                          'Enter a username to find new friends',
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
                      return _buildUserCard(user);
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
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
                      user['displayName'],
                      style: const TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '@${user['username']}',
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 14,
                        color: Colors.brown.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.public, size: 14, color: Colors.brown.shade500),
                        const SizedBox(width: 4),
                        Text(
                          user['country'],
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 13,
                            color: Colors.brown.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (user['bio'] != null && user['bio'].isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              user['bio'],
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
          if (user['interests'] != null && user['interests'].isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: (user['interests'] as List).take(3).map((interest) {
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

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Navigate to view profile
                  },
                  icon: Icon(Icons.person_outline, size: 18, color: Colors.brown.shade700),
                  label: Text(
                    'View Profile',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      color: Colors.brown.shade700,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.brown.shade300, width: 1.5),
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
          ),
        ],
      ),
    );
  }
}