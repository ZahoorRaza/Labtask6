import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madproject/main.dart';
import 'package:madproject/utilis/colors.dart';

import '../utilis/reusable widgets.dart';


class Loginpage extends StatefulWidget {
  final Function()? onTap ;
  const Loginpage({super.key,required this.onTap});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void signin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text.trim(),
        password: passwordTextController.text.trim(),
      );

      // Navigate to the home page or dashboard after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Replace HomePage() with your actual home page widget
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred.";
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password provided for that user.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      }

      // Show error SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20),
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      // Catch any other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unknown error occurred.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60,),
           const Icon(
              Icons.lock ,
              size: 100,
            ),
            SizedBox(
              height: 50,
            ),
            myTextField(
              controller: emailTextController,
              hintText: "Email",
              obsecureText: false,
            ),
            SizedBox(height: 10),
            myTextField(
              controller: passwordTextController,
              hintText: "password",
              obsecureText: true,
            ),

            SizedBox(height: 10,),
            myButton(onTap: signin,
                text: 'Log in'),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment:  MainAxisAlignment.center,
              children: <Widget>[
                Text("Not a member"),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text("Sign up",
                    style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
                )
                ,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
