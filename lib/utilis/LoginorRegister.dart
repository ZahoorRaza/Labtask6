

import 'package:flutter/material.dart';

import '../views/LoginPage.dart';
import '../views/LogupPage.dart';

class LoginorRegister extends StatefulWidget {
  const LoginorRegister({super.key});

  @override
  State<LoginorRegister> createState() => _LoginorRegisterState();
}

class _LoginorRegisterState extends State<LoginorRegister> {
  bool showLoginPage = true;

  void togglePage(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if  (showLoginPage)
    {
      return Loginpage(onTap: togglePage);
    }
    else
    {
      return RegisterPage(onTap: togglePage);
    }
  }
}