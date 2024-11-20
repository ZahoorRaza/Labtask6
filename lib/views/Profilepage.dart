import 'package:flutter/material.dart';
import '../utilis/colors.dart';
import '../utilis/reusable widgets.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final List<String> imagePaths = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
    'assets/4.png',
    'assets/2.png',
    'assets/1.png',
    'assets/3.png',


  ];
  @override
  Widget build(BuildContext context) {
    int? publishedPost = 10;
    int? Follwers = 13;
    int? Following = 149;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 500,
            height: 270,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    width: double.infinity,
                  child: Image.asset("assets/BackPicture.png"),
                ),

                ),

                Positioned(
                  bottom: 60,
                  left: 30,
                  child: Container(
                    width: 350,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20)),
                      color: whiteColor,

                    ),

                  ),
                ),

                Positioned(
                left: 150,
                bottom: 40,
                child: Container(
                child: Image.asset("assets/myProfilePic.png")
                ),
                ),

                Positioned(
                  bottom: 15,
                  left: 150,
                  child: Container(
                    child: Text("@fashion_me",style: TextStyle(fontWeight: FontWeight.bold),),

                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              SizedBox(width: 30,),

                  Container(
                    child: Image.asset("assets/iconProfile.png"),
                  ),
                  Container(
                    child: Text("#fashion_me",style: TextStyle(fontWeight: FontWeight.w500),),
                  ),
              SizedBox(width: 10,),

              Container(
                child: Image.asset("assets/iconLocation.png"),
              ),
              Container(
                child: Text("Quetta,Pakistan",style: TextStyle(fontWeight: FontWeight.w500),),
              ),
              SizedBox(width: 10,),

              Container(
                child: Image.asset("assets/iconCake.png"),
              ),
              Container(
                child: Text("20 july 2003",style: TextStyle(fontWeight: FontWeight.w500),),
              )
            ],
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              SizedBox(width: 150,),
              Image.asset("assets/add.png"),
              SizedBox(width: 5,),
              Text("Add new post",style: TextStyle(fontWeight: FontWeight.w300),),


            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              SizedBox(width: 100,),
              Text("10", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
                SizedBox(width: 40,),
                Text("1.3K", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
                  SizedBox(width: 40,),
                  Text("149", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),


                ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              SizedBox(width: 100,),
              Text("Posts", style: TextStyle(fontWeight: FontWeight.w300)),
              SizedBox(width: 30,),
              Text("Followers", style: TextStyle(fontWeight: FontWeight.w300)),
              SizedBox(width: 30,),
              Text("Following", style: TextStyle(fontWeight: FontWeight.w300)),
            ],
          ),
          Container(
            width: double.infinity,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(2, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 9,
              itemBuilder: (context,index)
                {
                return Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(imagePaths[index]),
                  ),
                );
                }

            ),
          )
        ],
      ),
    );
  }
}
