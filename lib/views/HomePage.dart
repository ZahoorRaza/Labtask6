import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:madproject/utilis/LoginorRegister.dart';
import 'package:madproject/views/Navigation.dart';
import '../utilis/CommentSection.dart';
import '../utilis/colors.dart';
import '../utilis/reusable widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_share/flutter_share.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();
  File? _pickedImage;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  void logout() async {
    bool? confirmLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );

    if (confirmLogout == true) {
      try {
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginorRegister()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error logging out: $e")),
        );
      }
    }
  }



  Future<void> pickImage() async {
    if (Platform.isAndroid) {
      final ImagePicker _picker = ImagePicker();

      final ImageSource? source = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Pick an Image"),
          backgroundColor: whiteColor,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(ImageSource.gallery);
              },
              child: const Text("Gallery"),
            ),

          ],
        ),
      );

      if (source != null) {
        final XFile? image = await _picker.pickImage(source: source);

        if (image != null) {
          setState(() {
            _pickedImage = File(image.path);
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Image picked successfully!")),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Image cannot be selected")),
      );
    }
  }


  Future<void> uploadPost(String content) async {
    if (_pickedImage != null || content.isNotEmpty) {
      try {
        String imageUrl = '';
        if (_pickedImage != null) {
          final storageRef = _firebaseStorage.ref().child('path/Zahoor/${DateTime.now().millisecondsSinceEpoch}');
          final uploadTask = storageRef.putFile(_pickedImage!);
          await uploadTask.whenComplete(() async {
            imageUrl = await storageRef.getDownloadURL();
          });
        }

        await _firestore.collection('posts').add({
          'content': content,
          'imageUrl': imageUrl,
          'likes': 0,
          'likedBy': [],
          'comments': [],
          'createdAt': Timestamp.now(),
          'userId': FirebaseAuth.instance.currentUser!.uid,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Post uploaded successfully!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error uploading post: $e")),
        );
      }
    }
  }

  void showAddPostDialog() {
    TextEditingController postController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Post"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _pickedImage != null
                ? Image.file(_pickedImage!)
                : const Text("No image selected."),
            const SizedBox(height: 10),
            TextField(
              controller: postController,
              decoration: const InputDecoration(hintText: "Enter your post content"),
              maxLines: 4,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: pickImage,
              child: const Text("Pick an Image"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _pickedImage = null;
              });
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              String postContent = postController.text.trim();
              uploadPost(postContent);
              setState(() {
                _pickedImage = null;
              });
              Navigator.of(context).pop();
            },
            child: const Text("Add Post"),
          ),
        ],
      ),
    );
  }

  Widget buildPostCard(DocumentSnapshot post) {
    List<dynamic> likedBy = post['likedBy'] != null ? List.from(post['likedBy']) : [];
    bool hasLiked = likedBy.contains(FirebaseAuth.instance.currentUser!.uid);

    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: _firestore.collection('users').doc(post['userId']).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return const Text("Error loading user data.");
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Text("User not found.");
              }

              var userData = snapshot.data!.data() as Map<String, dynamic>?;
              String userName = userData?['username'] ?? 'Unknown User';

              return Container(
                color: primaryColor,
                padding: const EdgeInsets.all(8),
                child: Text(
                  userName,
                  style: const TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
          if (post['imageUrl'] != '')
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                post['imageUrl'],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(post['content']),
          ),
          Row(
            children: [
              // Like button
              IconButton(
                icon: Icon(
                  Icons.thumb_up,
                  color: hasLiked ? primaryColor : Colors.grey,
                ),
                onPressed: () async {
                  try {
                    if (hasLiked) {
                      await _firestore.collection('posts').doc(post.id).update({
                        'likes': FieldValue.increment(-1),
                        'likedBy': FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
                      });
                    } else {
                      await _firestore.collection('posts').doc(post.id).update({
                        'likes': FieldValue.increment(1),
                        'likedBy': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
                      });
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(hasLiked ? "You unliked this post!" : "You liked this post!")),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error updating like: $e")),
                    );
                  }
                },
              ),
              Text('${post['likes']} likes'),
              IconButton(
                icon: const Icon(Icons.comment),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentSection(postId: post.id),
                    ),
                  );
                },
              ),
              const Text("Comments"),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () async {
                  await FlutterShare.share(
                    title: 'Share Post',
                    text: post['content'],
                    linkUrl: 'https://example.com', // Add a link if needed
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cocolia",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('posts').orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error fetching posts."));
          }

          final posts = snapshot.data!.docs;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (ctx, index) {
              return buildPostCard(posts[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddPostDialog,
        child: const Icon(Icons.add),

      ),
    );
  }
}
