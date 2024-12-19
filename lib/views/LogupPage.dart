import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madproject/utilis/ProfileName.dart';
import '../utilis/reusable widgets.dart'; // Make sure this contains your reusable widgets like `myTextField` and `myButton`
import '../utilis/colors.dart';
import '../main.dart'; // Assuming HomePage is imported from main.dart

class RegisterPage extends StatefulWidget {
  final Function()? onTap; // Not used in this case, but can be used for future navigation
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final enterUserName = TextEditingController();

  Future<void> register() async {
    final email = emailTextController.text.trim();
    final password = passwordTextController.text.trim();
    final confirmPassword = confirmPasswordTextController.text.trim();
    final username = enterUserName.text.trim();  // Get the username from the text controller

    // Basic input validation
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill out all fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'email': email,
        'username': username,
        'userId': userId,
        'profilePicture': '',  // Optional: add profile picture URL if available
        'createdAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to HomePage after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Navigate to HomePage after registration
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred.";
      if (e.code == 'weak-password') {
        errorMessage = 'The password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'An account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20),
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An unknown error occurred.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock,
              size: 50,
            ),
            myTextField(
              controller: emailTextController,
              hintText: "Email",
              obsecureText: false,
            ),
            const SizedBox(height: 10),
            myTextField(
              controller: passwordTextController,
              hintText: "Password",
              obsecureText: true,
            ),
            const SizedBox(height: 10),
            myTextField(
              controller: confirmPasswordTextController,
              hintText: "Confirm Password",
              obsecureText: true,
            ),
            const SizedBox(height: 10),
            myTextField(
              controller: enterUserName,
              hintText: "Enter Username",
              obsecureText: false,
            ),
            const SizedBox(height: 20),
            myButton(
              onTap: register,
              text: 'Sign Up',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already a member?"),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileNamePage(userId: 'newUser')), // Adjust this if needed
                    );
                  },
                  child: const Text(
                    "Log in",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
