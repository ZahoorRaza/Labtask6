import 'package:flutter/material.dart';
import '../utilis/colors.dart';
import '../utilis/reusable widgets.dart';

class extensionPage extends StatefulWidget {
  const extensionPage({super.key});

  @override
  State<extensionPage> createState() => _extensionPageState();
}

class _extensionPageState extends State<extensionPage> {
  @override
  Widget build(BuildContext cont3ext) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              customContainerExtension(double.maxFinite,740,null,0,null,null,"assets/extension.jpg"),
              customContainerExtension(double.maxFinite,740,null,0,null,null,"assets/play.png"),
              customContainerExtension(null,null,null,60,0,null,"assets/myRec.png"),
              customContainerExtension(null,null,420,null,30,null,"assets/shallowheart.png"),
              Container(
                child: Positioned(
                  top: 460,
                  right: 30,
                  child: Text("5.3m",style: TextStyle(color:whiteColor),),
                ),
              ),
              customContainerExtension(null,null,530,null,30,null,"assets/shallowcomment.png"),

              Container(
                child: Positioned(
                  top: 520,
                  right: 30,
                  child: Image.asset("assets/shallowcomment.png"),
                ),
              ),
              Container(
                child: Positioned(
                  top: 560,
                  right: 30,
                  child: Text("700k",style: TextStyle(color:whiteColor),),
                ),
              ),
              customContainerExtension(null,null,null,90,30,null,"assets/shallowshare.png"),
              Container(
                child: Positioned(
                  bottom: 60,
                  right: 30,
                  child: Text("230k",style: TextStyle(color:whiteColor),),
                ),
              ),
              customContainerExtension(null,null,null,30,null,10,"assets/picMypic.png"),
              customContainerExtension(null,null,null,10,null,50,"assets/music.png"),
              Container(
                child: Positioned(
                  bottom: 35,
                  left: 70,
                  child: Text("Follow",style: TextStyle(color: whiteColor),),
                ),
              ),
              Container(
                child: Positioned(
                  bottom: 35,
                  left: 130,
                  child: Text("see description",style: TextStyle(color: primaryColor),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
