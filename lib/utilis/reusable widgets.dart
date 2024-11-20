import 'package:flutter/material.dart';
import 'colors.dart';

Widget createCustomIcon(String imagePath, double _left, double _right, double _bottom, double _top, double? _width, double? _height)
{
  print(
    {"String $imagePath","double $_left","int $_right","int $_bottom","int $_top"}
  );
  return Padding(
    padding: EdgeInsets.fromLTRB(_left, _top, _right, _bottom),
    child: Container(
      decoration: BoxDecoration(
        color: whiteColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Image.asset(imagePath,
        width: _width,
        height: _height,
      ),
    ),

  );

}


Widget createCustomFeed(String u_name, String userPost)
{
  return Card(
      child: Column(
        children: [
          SizedBox(height: 20,),
          Stack(
            children: [
              Image.asset("assets/Rectangle 2.png"),

              Positioned(
                left: 30,
                top: 13,
                child: Text(u_name,
                  style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.w900,
                  ),),
              ),
            ],
          ),

          Image.asset(userPost),
          Row(
            children: [
              SizedBox(width:50,height: 30,),
              Image.asset("assets/heart.png"),
              SizedBox(width:20,height: 30,),
              Image.asset("assets/comment.png"),
              SizedBox(width:20,height: 30,),
              Image.asset("assets/share.png"),
              SizedBox(width:20,height: 30,),
              SizedBox(width:160,height: 30,),
              Image.asset("assets/createPost.png"),




            ],
          ),
          Container(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "$u_name: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "Hello i am using facebook nice to meet you",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              )
          ),
        ],

      )

  );
}

Widget messgaeFeed(String profilePic, String titleText, String subText)
{
 return ListTile(
    leading: Image.asset(profilePic),
    title: Text(titleText),
    subtitle: Text(subText),
    trailing: Image.asset("assets/isActiveDot.png"),

  );
}

Widget customContainerExtension(double? width, double? height, double? top, double? bottom,double? right,double? left,String myFeed)
{
return  Container(
    width: width,
    height: height,
    child: Positioned(
      top: top,
      bottom: bottom,
      right: right,
      left: left,
      child: Image.asset(myFeed),


    ),
  );
}



