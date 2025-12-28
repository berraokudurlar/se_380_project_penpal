import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se_380_project_penpal/models/friend_request_model.dart';
import 'package:se_380_project_penpal/models/user_model.dart';

class KeyPalsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get currentUserId => _auth.currentUser?.uid;

  /// Send a friend request to another user
  Future<String?> sendFriendRequest(String toUserId) async {
    try {
      final fromUserId = currentUserId;
      if (fromUserId == null) throw Exception("User not logged in");

      if (fromUserId == toUserId) {
        throw Exception("You cannot send a key pal request to yourself");
      }

      // Check if already friends
      final currentUserDoc = await _firestore
          .collection('users')
          .doc(fromUserId)
          .get();

      final friends = currentUserDoc.data()?['friends'] as List<dynamic>?;
      if (friends != null && friends.contains(toUserId)) {
        throw Exception("You are already key pals with this user");
      }

      // Check if request already exists
      final existingRequest = await _firestore
          .collection('friendRequests')
          .where('fromUserId', isEqualTo: fromUserId)
          .where('toUserId', isEqualTo: toUserId)
          .where('status', isEqualTo: 'pending')
          .get();

      if (existingRequest.docs.isNotEmpty) {
        throw Exception("Friend request already sent");
      }

      // Check if there's a pending request from the other user
      final reverseRequest = await _firestore
          .collection('friendRequests')
          .where('fromUserId', isEqualTo: toUserId)
          .where('toUserId', isEqualTo: fromUserId)
          .where('status', isEqualTo: 'pending')
          .get();

      if (reverseRequest.docs.isNotEmpty) {
        throw Exception("This user has already sent you a friend request. Check your pending requests!");
      }

      // Create friend request
      final requestRef = _firestore.collection('friendRequests').doc();
      final request = FriendRequestModel(
        requestId: requestRef.id,
        fromUserId: fromUserId,
        toUserId: toUserId,
        createdAt: DateTime.now(),
      );

      await requestRef.set(request.toJson());
      return requestRef.id;
    } catch (e) {
      print("Error sending friend request: $e");
      rethrow;
    }
  }

  /// Accept a friend request
  Future<void> acceptFriendRequest(String requestId) async {
    try {
      final userId = currentUserId;
      if (userId == null) throw Exception("User not logged in");

      // Get the request
      final requestDoc = await _firestore
          .collection('friendRequests')
          .doc(requestId)
          .get();

      if (!requestDoc.exists) {
        throw Exception("Key pal request not found");
      }

      final request = FriendRequestModel.fromJson(requestDoc.data()!);

      if (request.toUserId != userId) {
        throw Exception("This request is not for you");
      }

      if (request.status != 'pending') {
        throw Exception("This request has already been ${request.status}");
      }

      // Use batch for atomic operation
      final batch = _firestore.batch();

      // Update request status
      batch.update(
        _firestore.collection('friendRequests').doc(requestId),
        {
          'status': 'accepted',
          'respondedAt': FieldValue.serverTimestamp(),
        },
      );

      // Add to both users' friends lists
      batch.update(
        _firestore.collection('users').doc(request.fromUserId),
        {
          'friends': FieldValue.arrayUnion([request.toUserId]),
        },
      );

      batch.update(
        _firestore.collection('users').doc(request.toUserId),
        {
          'friends': FieldValue.arrayUnion([request.fromUserId]),
        },
      );

      await batch.commit();
    } catch (e) {
      print("Error accepting friend request: $e");
      rethrow;
    }
  }

  /// Reject a friend request
  Future<void> rejectFriendRequest(String requestId) async {
    try {
      final userId = currentUserId;
      if (userId == null) throw Exception("User not logged in");

      // Get the request
      final requestDoc = await _firestore
          .collection('friendRequests')
          .doc(requestId)
          .get();

      if (!requestDoc.exists) {
        throw Exception("Friend request not found");
      }

      final request = FriendRequestModel.fromJson(requestDoc.data()!);

      if (request.toUserId != userId) {
        throw Exception("This request is not for you");
      }

      if (request.status != 'pending') {
        throw Exception("This request has already been ${request.status}");
      }

      // Update request status
      await _firestore.collection('friendRequests').doc(requestId).update({
        'status': 'rejected',
        'respondedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error rejecting friend request: $e");
      rethrow;
    }
  }

  /// Cancel a sent friend request
  Future<void> cancelFriendRequest(String requestId) async {
    try {
      final userId = currentUserId;
      if (userId == null) throw Exception("User not logged in");

      final requestDoc = await _firestore
          .collection('friendRequests')
          .doc(requestId)
          .get();

      if (!requestDoc.exists) {
        throw Exception("Key pal request not found");
      }

      final request = FriendRequestModel.fromJson(requestDoc.data()!);

      if (request.fromUserId != userId) {
        throw Exception("You did not send this request");
      }

      // Delete the request
      await _firestore.collection('friendRequests').doc(requestId).delete();
    } catch (e) {
      print("Error canceling key pal request: $e");
      rethrow;
    }
  }

  /// Remove a friend
  Future<void> removeFriend(String friendUserId) async {
    try {
      final userId = currentUserId;
      if (userId == null) throw Exception("User not logged in");

      final batch = _firestore.batch();

      // Remove from both users' friends lists
      batch.update(
        _firestore.collection('users').doc(userId),
        {
          'friends': FieldValue.arrayRemove([friendUserId]),
        },
      );

      batch.update(
        _firestore.collection('users').doc(friendUserId),
        {
          'friends': FieldValue.arrayRemove([userId]),
        },
      );

      await batch.commit();
    } catch (e) {
      print("Error removing key pal: $e");
      rethrow;
    }
  }

  /// Get pending friend requests (received by current user)
  Stream<List<FriendRequestModel>> getPendingRequests() {
    final userId = currentUserId;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('friendRequests')
        .where('toUserId', isEqualTo: userId)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => FriendRequestModel.fromJson(doc.data()))
          .toList();
    });
  }

  /// Get sent friend requests (sent by current user)
  Stream<List<FriendRequestModel>> getSentRequests() {
    final userId = currentUserId;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('friendRequests')
        .where('fromUserId', isEqualTo: userId)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => FriendRequestModel.fromJson(doc.data()))
          .toList();
    });
  }

  /// Get user info by ID
  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (!doc.exists) return null;
      return UserModel.fromJson(doc.data()!);
    } catch (e) {
      print("Error getting user: $e");
      return null;
    }
  }

  /// Search users by username
  Future<List<UserModel>> searchUsers(String query) async {
    try {
      final userId = currentUserId;
      if (userId == null) throw Exception("User not logged in");

      final querySnapshot = await _firestore
          .collection('users')
          .where('username', isGreaterThanOrEqualTo: query.toLowerCase())
          .where('username', isLessThanOrEqualTo: '${query.toLowerCase()}\uf8ff')
          .limit(20)
          .get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .where((user) => user.userId != userId) // Exclude current user
          .toList();
    } catch (e) {
      print("Error searching users: $e");
      return [];
    }
  }

  /// Check friendship status with another user
  Future<String> getFriendshipStatus(String otherUserId) async {
    try {
      final userId = currentUserId;
      if (userId == null) return 'not_logged_in';

      // Check if already friends
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final friends = userDoc.data()?['friends'] as List<dynamic>?;

      if (friends != null && friends.contains(otherUserId)) {
        return 'friends';
      }

      // Check if request sent
      final sentRequest = await _firestore
          .collection('friendRequests')
          .where('fromUserId', isEqualTo: userId)
          .where('toUserId', isEqualTo: otherUserId)
          .where('status', isEqualTo: 'pending')
          .get();

      if (sentRequest.docs.isNotEmpty) {
        return 'request_sent';
      }

      // Check if request received
      final receivedRequest = await _firestore
          .collection('friendRequests')
          .where('fromUserId', isEqualTo: otherUserId)
          .where('toUserId', isEqualTo: userId)
          .where('status', isEqualTo: 'pending')
          .get();

      if (receivedRequest.docs.isNotEmpty) {
        return 'request_received';
      }

      return 'not_friends';
    } catch (e) {
      print("Error checking key pal status: $e");
      return 'error';
    }
  }

  /// Get all friends of current user
  Stream<List<UserModel>> getFriends() {
    final userId = currentUserId;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .asyncMap((snapshot) async {
      if (!snapshot.exists) return <UserModel>[];

      final friends = snapshot.data()?['friends'] as List<dynamic>?;
      if (friends == null || friends.isEmpty) return <UserModel>[];

      final friendDocs = await Future.wait(
        friends.map((friendId) =>
            _firestore.collection('users').doc(friendId as String).get()
        ),
      );

      return friendDocs
          .where((doc) => doc.exists)
          .map((doc) => UserModel.fromJson(doc.data()!))
          .toList();
    });
  }
}