import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class FirebaseUserService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Uploads a profile picture to Firebase Storage and returns the download URL.
  Future<String> uploadProfilePicture(String userId, File imageFile) async {
    try {
      // Define the storage reference
      final storageRef = _firebaseStorage.ref().child(
          'profile_pictures/$userId');

      // Upload the file
      final uploadTask = storageRef.putFile(imageFile);

      // Await completion
      await uploadTask.whenComplete(() {});

      // Return the download URL
      return await storageRef.getDownloadURL();
    } catch (e) {
      // Log and rethrow the error
      print('Error in uploadProfilePicture: $e');
      throw Exception('Failed to upload profile picture.');
    }
  }

  /// Adds a user to Firestore with username and profile picture URL.
  Future<void> addUserDetails(String userId, String username,
      String? imageUrl) async {
    try {
      // If imageUrl is null, use a default URL
      String profilePicUrl = imageUrl ??
          'https://path/to/default/profile/image.png';

      // Save user details in Firestore
      await _firestore.collection('users').doc(userId).set({
        'username': username,
        'profilePicUrl': profilePicUrl,
        // Store the profile picture URL
        'createdAt': FieldValue.serverTimestamp(),
        // Optional: track creation time
      });
    } catch (e) {
      // Log and rethrow the error
      print('Error in addUserDetails: $e');
      throw Exception('Failed to add user details.');
    }
  }
}
