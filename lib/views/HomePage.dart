import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:madproject/views/Navigation.dart';
import '../utilis/colors.dart';
import '../utilis/reusable widgets.dart';
import 'All_chat_contacts_page.dart';


class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {

    int _selectedIndex = 0;
    PageController _pageController = PageController();

    return Scaffold(
       body: Column(
         children: [
           Row(
             children: [
               createCustomIcon("assets/game.png", 15,0, 0, 30,null,null),
               createCustomIcon("assets/search.png",250, 0, 0, 30,null,null),
               createCustomIcon("assets/chat.png",30, 0, 0, 30,null,null),
               createCustomIcon("assets/call.png",20, 0, 0, 30,null,null),
             ],
           ),
           Stack(
             children: [
               createCustomIcon("assets/linearBlue.png", 20, 0, 0, 30,50,50),
               createCustomIcon("assets/linearBlue.png", 80, 0, 0, 30,50,50),
               createCustomIcon("assets/linearBlue.png", 140, 0, 0, 30,50,50),
               createCustomIcon("assets/linearBlue.png", 200, 0, 0, 30,50,50),
               createCustomIcon("assets/linearBlue.png", 260, 0, 0, 30,50,50),
               createCustomIcon("assets/linearBlue.png", 320, 0, 0, 30,50,50),

               createCustomIcon("assets/blackCreate.png", 30, 0, 0, 40,30,30),
               createCustomIcon("assets/pro1.png", 90, 0, 0, 40,30,30),
               createCustomIcon("assets/pro2.png", 150, 0, 0, 40,30,30),
               createCustomIcon("assets/pro1.png", 210, 0, 0, 40,30,30),
               createCustomIcon("assets/pro3.png", 270, 0, 0, 40,30,30),
               createCustomIcon("assets/pro2.png", 330, 0, 0, 40,30,30),

             ],
           ),
            Expanded(child: ListView(
              children: [
                createCustomFeed("Boruto", "assets/Rectangle 1.png"),
                createCustomFeed("Kakarot", "assets/Rectangle 1.png"),
                createCustomFeed("Raza", "assets/Rectangle 1.png"),
                createCustomFeed("Boruto", "assets/Rectangle 1.png"),
                createCustomFeed("Kakarot", "assets/Rectangle 1.png"),
                createCustomFeed("Raza", "assets/Rectangle 1.png"),

              ],

            )),





         ],
       ),

           );
  }
}
