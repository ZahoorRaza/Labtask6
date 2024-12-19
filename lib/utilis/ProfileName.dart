import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:madproject/main.dart';
import 'package:madproject/utilis/Profile.dart'; // Import the HomePage here

class ProfileNamePage extends StatefulWidget {
  final String userId;

  const ProfileNamePage({super.key, required this.userId});

  @override
  _ProfileNamePageState createState() => _ProfileNamePageState();
}

class _ProfileNamePageState extends State<ProfileNamePage> {
  final TextEditingController usernameController = TextEditingController();
  File? _pickedImage;

  // Method to pick the profile image
  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  // Method to submit the profile and register the user
  Future<void> submitProfile() async {
    final username = usernameController.text.trim();

    // Check if the username is empty
    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a username."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Register the user if they aren't registered already
      User? user = FirebaseAuth.instance.currentUser;

      // If no user is logged in, register the user
      if (user == null) {
        // Register user using email and password, as an example
        final email = 'example@example.com';  // You can fetch the email dynamically from a TextField
        final password = 'password123';  // Fetch password dynamically as well
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        user = userCredential.user;
      }

      String imageUrl = '';
      if (_pickedImage != null) {
        // Upload profile picture if selected
        imageUrl = await FirebaseUserService().uploadProfilePicture(widget.userId, _pickedImage!);
      }

      // Add the user details (username and image URL) to Firestore
      await FirebaseUserService().addUserDetails(widget.userId, username, imageUrl);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile created successfully!"),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate directly to HomePage after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),  // Directly use HomePage() here
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to create profile."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Your Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile picture selection
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _pickedImage != null
                    ? FileImage(_pickedImage!)
                    : const AssetImage('assets/default_profile.png') as ImageProvider,
              ),
            ),
            const SizedBox(height: 20),

            // Username input field
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: "Enter Username",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Submit button
            ElevatedButton(
              onPressed: submitProfile,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
