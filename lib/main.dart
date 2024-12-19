import 'package:flutter/material.dart';
import 'package:madproject/utilis/AuthPage.dart';
import 'package:madproject/views/All_chat_contacts_page.dart';
import 'package:madproject/views/HomePage.dart';
import 'package:madproject/views/Navigation.dart';
import 'package:madproject/views/Profilepage.dart';
import 'package:madproject/views/extensionPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of pages (your individual pages)
  final List<Widget> _pages = [
    homePage(),
    extensionPage(),
    ChatsPage(),
    ProfilePage(),
  ];

  // Handle navigation on BottomNavyBarItem tap
  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavBarWidget(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemSelected,
      ),
    );
  }
}



