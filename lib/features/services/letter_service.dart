import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se_380_project_penpal/models/letter_model.dart';

import 'letter_delivery_service.dart';



class LetterService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  /// Send a letter to another user
  Future<String?> sendLetter({
    required String receiverUsername,
    required String contentText,
    String? contentHtml,
  }) async {
    try {
      final senderId = currentUserId;
      if (senderId == null) throw Exception("User not logged in");

      final senderDoc =
      await _firestore.collection('users').doc(senderId).get();


      final senderCountryCode = senderDoc.data()?['countryCode'];
      final senderCountryName = senderDoc.data()?['country'];



      // Find receiver by username
      final receiverQuery = await _firestore
          .collection('users')
          .where('username', isEqualTo: receiverUsername)
          .limit(1)
          .get();

      if (receiverQuery.docs.isEmpty) {
        throw Exception("User '$receiverUsername' not found");
      }

      final receiverDoc = receiverQuery.docs.first;
      final receiverId = receiverDoc.id;



      final receiverCountryCode = receiverDoc.data()['countryCode'];
      final receiverCountryName = receiverDoc.data()['country'];


      //Arrival Time
      final now = DateTime.now();
      final int arrivalDays =
      LetterDeliveryService.calculateArrivalDays(
        senderCountryCode: senderCountryCode,
        receiverCountryCode: receiverCountryCode,
      );

      final DateTime estimatedArrivalDate =
      now.add(Duration(days: arrivalDays));





      // Create letter document reference
      final letterRef = _firestore.collection('letters').doc();


      // Create the letter model
      final letter = LetterModel(
        letterId: letterRef.id,
        senderId: senderId,
        receiverId: receiverId,
        sentDate: now,
        estimatedArrivalDays: arrivalDays,
        estimatedArrivalDate: estimatedArrivalDate,
        status: 'sent',
        contentText: contentText,
        locationSentFrom:senderCountryName,
        locationReceived:receiverCountryName,
        customizations: contentHtml != null ? {'html': contentHtml} : null,
      );
      


      // Use batch write for atomic operation
      final batch = _firestore.batch();

      // Write letter
      batch.set(letterRef, letter.toJson());

      // Update sender's lettersSent array
      final senderRef = _firestore.collection('users').doc(senderId);
      batch.update(senderRef, {
        'lettersSent': FieldValue.arrayUnion([letterRef.id]),
      });

      // Update receiver's lettersReceived array
      final receiverRef = _firestore.collection('users').doc(receiverId);
      batch.update(receiverRef, {
        'lettersReceived': FieldValue.arrayUnion([letterRef.id]),
      });

      // Commit all changes atomically
      await batch.commit();

      return letterRef.id;
    } catch (e) {
      print("Error sending letter: $e");
      rethrow;
    }
  }

  /// Get all received letters for current user
  Stream<List<LetterModel>> getReceivedLetters() {
    final userId = currentUserId;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('letters')
        .where('receiverId', isEqualTo: userId)
        .where('status', isEqualTo: 'delivered') // Only delivered letters
        .where('deleted', isEqualTo: false)
        .orderBy('sentDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => LetterModel.fromJson(doc.data()))
          .toList();
    });
  }

  /// Get all sent letters for current user
  Stream<List<LetterModel>> getSentLetters() {
    final userId = currentUserId;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('letters')
        .where('senderId', isEqualTo: userId)
        .where('deleted', isEqualTo: false)
        .orderBy('sentDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => LetterModel.fromJson(doc.data()))
          .toList();
    });
  }


  /// Get basic public user info by userId
  Future<Map<String, dynamic>?> getUserBasicInfo(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (!doc.exists) return null;

      final data = doc.data()!;
      return {
        'displayName': data['displayName'] ?? 'Unknown',
        'username': data['username'] ?? 'unknown',
        'country': data['country'],
      };
    } catch (e) {
      print("Error getting user info: $e");
      return null;
    }
  }



  /// Delete a letter (soft delete)
  Future<void> deleteLetter(String letterId) async {
    try {
      await _firestore.collection('letters').doc(letterId).update({
        'deleted': true,
      });
    } catch (e) {
      print("Error deleting letter: $e");
      rethrow;
    }
  }

  /// Get a single letter by ID
  Future<LetterModel?> getLetterById(String letterId) async {
    try {
      final doc = await _firestore.collection('letters').doc(letterId).get();
      if (!doc.exists) return null;
      return LetterModel.fromJson(doc.data()!);
    } catch (e) {
      print("Error getting letter: $e");
      return null;
    }
  }

  Future<void> checkAndUpdateDeliveredLetters() async {
    final userId = currentUserId;
    if (userId == null) return;

    final now = DateTime.now();

    final query = await _firestore
        .collection('letters')
        .where('receiverId', isEqualTo: userId)
        .where('status', isEqualTo: 'sent')
        .get();

    for (final doc in query.docs) {
      final data = doc.data();
      final Timestamp? arrivalTs = data['estimatedArrivalDate'];

      if (arrivalTs == null) continue;

      final arrivalDate = arrivalTs.toDate();

      if (now.isAfter(arrivalDate)) {
        await doc.reference.update({
          'status': 'delivered',
          'receivedDate': now,
        });
      }
    }
  }



}