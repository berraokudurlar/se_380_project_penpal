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

  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (!doc.exists) return null;
      return UserModel.fromJson(doc.data()!);
    } catch (e) {
      rethrow;
    }
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

  Future<UserModel> updateProfileAndReturn({
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

    // Mevcut kullanıcıyı al
    final currentUser = await getUserById(uid);
    if (currentUser == null) {
      throw Exception("User document not found");
    }

    // Yeni UserModel üret
    final updatedUser = currentUser.copyWith(
      displayName: displayName,
      username: username,
      bio: bio,
      country: country,
      isCountryPublic: isCountryPublic,
      age: age,
      isAgePublic: isAgePublic,
      interests: interests,
      languages: languages,
      lastActive: DateTime.now(),
    );

    // Firestore'a yaz
    await _firestore
        .collection('users')
        .doc(uid)
        .update(updatedUser.toJson());

    // UI için geri döndür
    return updatedUser;
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
