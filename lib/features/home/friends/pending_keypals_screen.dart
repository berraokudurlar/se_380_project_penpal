import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart';
import 'package:se_380_project_penpal/features/services/keypals_service.dart';
import 'package:se_380_project_penpal/models/friend_request_model.dart';
import 'package:se_380_project_penpal/models/user_model.dart';
import 'package:intl/intl.dart';

class PendingKeypalsScreen extends StatefulWidget {
  const PendingKeypalsScreen({super.key});

  @override
  State<PendingKeypalsScreen> createState() => _PendingKeypalsScreenState();
}

class _PendingKeypalsScreenState extends State<PendingKeypalsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final KeyPalsService _friendService = KeyPalsService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Friend Requests',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 24,
            color: AppColors.textDark,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.brown.shade800,
          unselectedLabelColor: Colors.brown.shade400,
          labelStyle: const TextStyle(
            fontFamily: 'Georgia',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          indicatorColor: Colors.brown.shade700,
          tabs: const [
            Tab(text: 'Received'),
            Tab(text: 'Sent'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildReceivedRequests(),
          _buildSentRequests(),
        ],
      ),
    );
  }

  Widget _buildReceivedRequests() {
    return StreamBuilder<List<FriendRequestModel>>(
      stream: _friendService.getPendingRequests(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.textMedium),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading requests',
              style: TextStyle(
                fontFamily: 'Georgia',
                color: Colors.red.shade700,
              ),
            ),
          );
        }

        final requests = snapshot.data ?? [];

        if (requests.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.mail_outline,
                  size: 80,
                  color: Colors.brown.shade300,
                ),
                const SizedBox(height: 16),
                Text(
                  'No pending requests',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 18,
                    color: Colors.brown.shade600,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: requests.length,
          itemBuilder: (context, index) {
            return _buildReceivedRequestCard(requests[index]);
          },
        );
      },
    );
  }

  Widget _buildReceivedRequestCard(FriendRequestModel request) {
    return FutureBuilder<UserModel?>(
      future: _friendService.getUserById(request.fromUserId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final user = snapshot.data!;
        final dateStr = DateFormat('MMM dd, yyyy').format(request.createdAt);

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.brown.shade200, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
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
                        const SizedBox(height: 4),
                        Text(
                          'Sent $dateStr',
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 12,
                            color: Colors.brown.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  // --- UPDATED: Changed from OutlinedButton to ElevatedButton ---
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _rejectRequest(request.requestId),
                      icon: const Icon(Icons.close, size: 18),
                      label: const Text(
                        'Decline',
                        style: TextStyle(fontFamily: 'Georgia'),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700, // Solid Red
                        foregroundColor: Colors.white, // White Text
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // --- Accept button was already correct ---
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _acceptRequest(request.requestId),
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text(
                        'Accept',
                        style: TextStyle(fontFamily: 'Georgia'),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white, // Already white
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
      },
    );
  }

  Widget _buildSentRequests() {
    return StreamBuilder<List<FriendRequestModel>>(
      stream: _friendService.getSentRequests(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.textMedium),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading requests',
              style: TextStyle(
                fontFamily: 'Georgia',
                color: Colors.red.shade700,
              ),
            ),
          );
        }

        final requests = snapshot.data ?? [];

        if (requests.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.send_outlined,
                  size: 80,
                  color: Colors.brown.shade300,
                ),
                const SizedBox(height: 16),
                Text(
                  'No sent requests',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 18,
                    color: Colors.brown.shade600,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: requests.length,
          itemBuilder: (context, index) {
            return _buildSentRequestCard(requests[index]);
          },
        );
      },
    );
  }

  Widget _buildSentRequestCard(FriendRequestModel request) {
    return FutureBuilder<UserModel?>(
      future: _friendService.getUserById(request.toUserId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final user = snapshot.data!;
        final dateStr = DateFormat('MMM dd, yyyy').format(request.createdAt);

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.brown.shade200, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
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
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 12, color: Colors.brown.shade500),
                        const SizedBox(width: 4),
                        Text(
                          'Sent $dateStr',
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 12,
                            color: Colors.brown.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // --- UPDATED: Changed from TextButton to ElevatedButton ---
              ElevatedButton(
                onPressed: () => _cancelRequest(request.requestId),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700, // Solid Red
                  foregroundColor: Colors.white, // White Text/Icon
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontFamily: 'Georgia'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _acceptRequest(String requestId) async {
    try {
      await _friendService.acceptFriendRequest(requestId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Key Pal request accepted! 🎉'),
            backgroundColor: Colors.green.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString().replaceAll('Exception: ', '')}'),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _rejectRequest(String requestId) async {
    try {
      await _friendService.rejectFriendRequest(requestId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Request declined'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString().replaceAll('Exception: ', '')}'),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _cancelRequest(String requestId) async {
    try {
      await _friendService.cancelFriendRequest(requestId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Request cancelled'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString().replaceAll('Exception: ', '')}'),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}