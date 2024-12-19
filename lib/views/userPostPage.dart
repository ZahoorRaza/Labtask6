import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:madproject/utilis/colors.dart';

class UserPostsPage extends StatefulWidget {
  final String userId;
  const UserPostsPage({super.key, required this.userId});

  @override
  State<UserPostsPage> createState() => _UserPostsPageState();
}

class _UserPostsPageState extends State<UserPostsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _userPosts = [];

  Future<void> _getUserPosts() async {
    String userId = widget.userId;

    if (userId.isNotEmpty) {
      QuerySnapshot postsSnapshot = await _firestore
          .collection('posts')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();
      setState(() {
        _userPosts = postsSnapshot.docs;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Posts"),
        backgroundColor: primaryColor,
      ),
      body: _userPosts.isEmpty
          ? const Center(child: Text('No posts available.'))
          : ListView.builder(
        itemCount: _userPosts.length,
        itemBuilder: (context, index) {
          var post = _userPosts[index];
          return Card(
            child: ListTile(
              title: Text(post['content']),
              subtitle: Text("By: ${post['username']}"),
            ),
          );
        },
      ),
    );
  }
}
