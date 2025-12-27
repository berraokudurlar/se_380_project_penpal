import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se_380_project_penpal/models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get currentUserId => _auth.currentUser?.uid;

  Future<UserModel?> getCurrentUser() async {
    final uid = currentUserId;
    if (uid == null) return null;
    return getUserById(uid);
  }

  Stream<UserModel?> streamCurrentUser() {
    final uid = currentUserId;
    if (uid == null) return const Stream.empty();
    return streamUserById(uid);
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (!doc.exists) return null;
      return UserModel.fromJson(doc.data()!);
    } catch (e) {
      rethrow;
    }
  }

  Stream<UserModel?> streamUserById(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map((snap) {
      if (!snap.exists || snap.data() == null) return null;
      return UserModel.fromJson(snap.data()!);
    });
  }

  Future<UserModel?> getUserByUsername(String username) async {
    try {
      final q = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();
      if (q.docs.isEmpty) return null;
      return UserModel.fromJson(q.docs.first.data());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.userId).set(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  /// Partial update
  Future<void> updateFields(Map<String, Object?> data) async {
    final uid = currentUserId;
    if (uid == null) throw Exception("User not authenticated");

    await _firestore.collection('users').doc(uid).update(data);
  }

  ///sonra düzenlencek user service kullanıp
  /// Update profile basic info (EditProfileScreen)
  Future<void> updateProfile({
    required String displayName,
    required String username,
    String? bio,
    String? country,
    bool? isCountryPublic,
    int? age,
    bool? isAgePublic,
    List<String>? interests,
    List<Map<String, String>>? languages,
  }) async {
    final uid = currentUserId;
    if (uid == null) throw Exception("User not authenticated");

    await _firestore.collection('users').doc(uid).update({
      'displayName': displayName,
      'username': username,
      'bio': bio,
      'country': country,
      'isCountryPublic': isCountryPublic,
      'age': age,
      'isAgePublic': isAgePublic,
      'interests': interests,
      'languages': languages,
      'lastActive': FieldValue.serverTimestamp(),
    });
  }


  Future<void> setCountryPublic(bool isPublic) async {
    final uid = currentUserId;
    if (uid == null) throw Exception("Not authenticated");
    try {
      await _firestore.collection('users').doc(uid).update({
        'isCountryPublic': isPublic,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setAgePublic(bool isPublic) async {
    final uid = currentUserId;
    if (uid == null) throw Exception("Not authenticated");
    try {
      await _firestore.collection('users').doc(uid).update({
        'isAgePublic': isPublic,
      });
    } catch (e) {
      rethrow;
    }
  }


  Future<void> addFriend(String friendId) async {
    final uid = currentUserId;
    if (uid == null) throw Exception("Not authenticated");
    try {
      await _firestore.collection('users').doc(uid).update({
        'friends': FieldValue.arrayUnion([friendId]),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeFriend(String friendId) async {
    final uid = currentUserId;
    if (uid == null) throw Exception("Not authenticated");
    try {
      await _firestore.collection('users').doc(uid).update({
        'friends': FieldValue.arrayRemove([friendId]),
      });
    } catch (e) {
      rethrow;
    }
  }



}
