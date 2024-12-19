    import 'package:cloud_firestore/cloud_firestore.dart';
    import 'package:firebase_auth/firebase_auth.dart';
    import 'package:flutter/material.dart';

    class CommentSection extends StatefulWidget {
      final String postId;
      const CommentSection({super.key, required this.postId});

      @override
      _CommentSectionState createState() => _CommentSectionState();
    }

    class _CommentSectionState extends State<CommentSection> {
      final TextEditingController _commentController = TextEditingController();

      Future<void> addComment() async {
        String comment = _commentController.text.trim();
        if (comment.isNotEmpty) {
          try {
            await FirebaseFirestore.instance.collection('posts').doc(widget.postId).update({
              'comments': FieldValue.arrayUnion([comment]),
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Comment added successfully!")),
            );

            _commentController.clear();
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error adding comment: $e")),
            );
          }
        }
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Comments"),
            backgroundColor: Colors.blue,
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection('posts').doc(widget.postId).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    var post = snapshot.data!;
                    return ListView(
                      children: (post['comments'] as List).map<Widget>((comment) {
                        return ListTile(
                          title: Text(comment),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          hintText: "Add a comment...",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: addComment,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    }
