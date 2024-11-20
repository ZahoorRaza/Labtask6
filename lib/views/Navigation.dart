import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:madproject/utilis/colors.dart';

class BottomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const BottomNavBarWidget({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      selectedIndex: selectedIndex,
      onItemSelected: (index) => onItemSelected(index),
      items: [
        BottomNavyBarItem(
          icon: Image.asset("assets/Home.png"),
          activeColor: primaryColor,
          inactiveColor: blackColor,
          title:Text("HomePage"),
        ),
        BottomNavyBarItem(
          icon: Image.asset("assets/Listss.png"),
          activeColor: primaryColor,
          inactiveColor: blackColor,
          title:Text("extension"),
        ),
        BottomNavyBarItem(
          icon: Image.asset("assets/notification.png"),
          activeColor: primaryColor,
          inactiveColor: blackColor,
          title:Text("chats"),
        ),
        BottomNavyBarItem(
          icon: Image.asset("assets/Profile.png"),
          activeColor: primaryColor,
          inactiveColor: blackColor,
          title:Text("Profile page"),
        ),
      ],
    );
  }
}
