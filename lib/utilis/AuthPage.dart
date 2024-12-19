


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madproject/utilis/LoginorRegister.dart';
import 'package:madproject/utilis/reusable%20widgets.dart';

import '../main.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if (snapshot.hasData)
            {
              return HomePage();
            }
            else{
              return LoginorRegister();
            }
          }),
    );
  }
}







