import 'dart:io';

import 'package:flutter/material.dart';
import 'package:madproject/main.dart';
import 'package:madproject/views/LoginPage.dart';
import 'package:madproject/views/LogupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:madproject/utilis/colors.dart';
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
      child: CircleAvatar(
        backgroundColor: Colors.blue,
        radius: 50,
      ),
    ),

  );

}

class Post {
  final String userName;
  final String postContent;
  final String? postImage;
  final DateTime createdAt;
  int likes;
  int comments;

  Post({
    required this.userName,
    required this.postContent,
    this.postImage,
    required this.createdAt,
    this.likes = 0,
    this.comments = 0,
  });
}

Widget createCustomFeed(Post post, BuildContext context, Function() onLike, Function() onComment) {
  return Card(
    child: Column(
      children: [
        SizedBox(height: 20),
        Stack(
          children: [
            Image.asset("assets/Rectangle 2.png"), // Background image
            Positioned(
              left: 30,
              top: 13,
              child: Text(
                post.userName,
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        post.postImage != null
            ? Image.network(post.postImage!)  // Display the image from URL
            : Image.asset("assets/Rectangle 1.png"), // Placeholder image
        Row(
          children: [
            SizedBox(width: 50, height: 30),
            IconButton(
              icon: Image.asset("assets/heart.png"),
              onPressed: onLike, // Trigger like functionality
            ),
            Text("${post.likes}", style: TextStyle(fontSize: 16)),
            SizedBox(width: 20, height: 30),
            IconButton(
              icon: Image.asset("assets/comment.png"),
              onPressed: onComment,
            ),
            Text("${post.comments}", style: TextStyle(fontSize: 16)),
            SizedBox(width: 20, height: 30),
            IconButton(
              icon: Image.asset("assets/share.png"),
              onPressed: () {
              },
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "${post.userName}: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: post.postContent,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
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



class myTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecureText;
  const myTextField({super.key, required  this.controller, required this.hintText ,required this.obsecureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsecureText,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: whiteColor)
        ),
        focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: whiteColor)
      ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500)

      ),
    );
  }
}



class myButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
    const myButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(8.0),


        ),
        child: Center(
            child: Text(
              text,
              style: TextStyle(color: whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),


            ),
        ),
      ),
    );
  }
}


