import 'package:flutter/material.dart';
import '../utilis/colors.dart';
import '../utilis/reusable widgets.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key});

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            Row(
              children: [
                  createCustomIcon("assets/game.png", 15,0, 0, 30,null,null),
                  createCustomIcon("assets/search.png",250, 0, 0, 30,null,null),
                  createCustomIcon("assets/chat.png",30, 0, 0, 30,null,null),
                  createCustomIcon("assets/call.png",20, 0, 0, 30,null,null),
                SizedBox(height: 35,),

              ],
    ),
        SizedBox(height: 30),
            Stack(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              width: 120,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(8)),


              ),
    ),

              Container(
            alignment: Alignment.bottomLeft,
                child: Text("Search contacts",
            style: TextStyle(color: primaryColor),
            ),
          ),
          ],
        ),
            SizedBox(height: 5,),
            Row(
            children: [
            Stack(
              children: [
                createCustomIcon("assets/blackLinear.png", 90, 0, 0, 40,50,50),
                createCustomIcon("assets/blackLinear.png", 150, 0, 0, 40,50,50),
                createCustomIcon("assets/blackLinear.png", 210, 0, 0, 40,50,50),
                createCustomIcon("assets/blackLinear.png", 270, 0, 0, 40,50,50),
                createCustomIcon("assets/blackLinear.png", 330, 0, 0, 40,50,50),
                createCustomIcon("assets/blackCreate.png", 30, 0, 0, 40,50,50),

                createCustomIcon("assets/pro1.png", 100, 0, 0, 50,30,30),
                createCustomIcon("assets/pro2.png", 160, 0, 0, 50,30,30),
                createCustomIcon("assets/pro1.png", 220, 0, 0, 50,30,30),
                createCustomIcon("assets/pro3.png", 280, 0, 0, 50,30,30),
                createCustomIcon("assets/pro2.png", 340, 0, 0, 50,30,30),
                ],
            ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 5,),
                Text("Direct Messages",
                  style: TextStyle(fontWeight: FontWeight.bold,color: blackColor),

                ),
             Spacer(),
                Text("0 Requests",
                style: TextStyle(color: blackColor.withOpacity(0.5)),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  messgaeFeed("assets/pro1.png","Goku","I am a saiyan raised on earth"),
                  messgaeFeed("assets/pro2.png","Raza","How is everyone doing"),
                  messgaeFeed("assets/pro1.png","Alise","and there i go down the rabbit hole"),
                  messgaeFeed("assets/pro1.png","rudy","you can't buy dere with money"),
                  messgaeFeed("assets/pro1.png","Graggle","I turned into a vermit this morning"),
                  messgaeFeed("assets/pro1.png","Nitzche","Act done for love goes beyong good and evil"),
                  messgaeFeed("assets/pro1.png","kafka","cry a ocean"),
                  messgaeFeed("assets/pro1.png","Gohan","i would like to eat rice"),
                  messgaeFeed("assets/pro1.png","Dazai","i am depressed"),
                  messgaeFeed("assets/pro1.png","Guts","when resilliance meets hope love is born"),

                ],
              ),
            ),

              ],

      ),
    );
  }
}

