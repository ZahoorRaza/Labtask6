import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madproject/utilis/colors.dart';
import 'package:madproject/views/likePostPage.dart';
import 'package:madproject/views/userPostPage.dart';
import 'dart:io';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  File? _pickedImage;
  String _userName = "";
  String _userEmail = "";
  String _profileImageUrl = "";
  String _userId = "";

  // Get User Profile Information
  void _getUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userData =
      await _firestore.collection('users').doc(user.uid).get();

      setState(() {
        _userName = userData['username'] ?? 'No name';
        _userEmail = userData['email'] ?? 'No email';
        _profileImageUrl = userData['profilePicture'] ?? '';
        _userId = user.uid;
      });
    }
  }

  // Pick Image for Profile
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  // Update Profile Image
  Future<void> _updateProfileImage() async {
    if (_pickedImage != null) {
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = _firebaseStorage.ref().child('profile_images/$fileName');
        await ref.putFile(_pickedImage!);
        String downloadUrl = await ref.getDownloadURL();

        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await _firestore.collection('users').doc(user.uid).update({
            'profilePicture': downloadUrl,
          });

          setState(() {
            _profileImageUrl = downloadUrl;
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error updating profile image: $e")),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: whiteColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: _profileImageUrl.isEmpty
                      ? const AssetImage('assets/default_profile.png')
                  as ImageProvider
                      : NetworkImage(_profileImageUrl),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                _userName,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue), // Replace with primaryColor if defined
              ),
              Text(
                _userEmail,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _updateProfileImage,
                child: const Text("Update Profile Image"),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPostsPage(userId: _userId)),
                  );
                },
                child: const Text("Your Posts"),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LikedPostsPage(userId: _userId)),
                  );
                },
                child: const Text("Liked Posts"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
