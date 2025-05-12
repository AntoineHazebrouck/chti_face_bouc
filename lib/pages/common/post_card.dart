import 'package:chti_face_bouc/modeles/post.dart';
import 'package:chti_face_bouc/pages/common/avatar.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        spacing: 10,
        children: [
          ListTile(
            leading: Row(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              children: [
                Avatar(member: post.member),
                Text("${post.member.firstname} ${post.member.lastname}"),
              ],
            ),
            trailing: Text(post.date.toDate().toIso8601String()),
          ),
          Divider(height: 10),
          Center(
            child: Column(
              children: [
                Text(post.text),
                if (post.imageUrl != null) Image.network(post.imageUrl!),
              ],
            ),
          ),
          Divider(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO
                  },
                  label: Text("${post.likes.length} Likes"),
                  icon: Icon(Icons.star_border),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO
                  },
                  label: Text("Commenter"),
                  icon: Icon(Icons.chat_bubble_outline),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
