import 'package:flutter/material.dart';
import 'package:madproject/views/All_chat_contacts_page.dart';
import 'package:madproject/views/HomePage.dart';
import 'package:madproject/views/Navigation.dart';
import 'package:madproject/views/Profilepage.dart';
import 'package:madproject/views/extensionPage.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
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
    chatPage(),
    profilePage(),
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



