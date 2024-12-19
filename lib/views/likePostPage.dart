import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikedPostsPage extends StatefulWidget {
  final String userId;
  const LikedPostsPage({super.key, required this.userId});

  @override
  State<LikedPostsPage> createState() => _LikedPostsPageState();
}

class _LikedPostsPageState extends State<LikedPostsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _likedPosts = [];

  // Get Liked Posts
  Future<void> _getLikedPosts() async {
    String userId = widget.userId;

    if (userId.isNotEmpty) {
      QuerySnapshot postsSnapshot = await _firestore
          .collection('posts')
          .where('likedBy', arrayContains: userId) // Filter posts by likedBy
          .orderBy('createdAt', descending: true)
          .get();
      setState(() {
        _likedPosts = postsSnapshot.docs;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getLikedPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liked Posts"),
        backgroundColor: Colors.blue, // Replace with primaryColor if defined
      ),
      body: _likedPosts.isEmpty
          ? const Center(child: Text('No liked posts.'))
          : ListView.builder(
        itemCount: _likedPosts.length,
        itemBuilder: (context, index) {
          var post = _likedPosts[index];
          return Card(
            child: ListTile(
              title: Text(post['content']),
              subtitle: Text("By: ${post['username']}"),
              trailing: Text(post['createdAt'].toDate().toString()), // Display timestamp
            ),
          );
        },
      ),
    );
  }
}
