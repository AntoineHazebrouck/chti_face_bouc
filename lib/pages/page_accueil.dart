import 'package:chti_face_bouc/modeles/post.dart';
import 'package:chti_face_bouc/pages/common/avatar.dart';
import 'package:chti_face_bouc/pages/common/my_name.dart';
import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:flutter/material.dart';

class PageAccueil extends StatefulWidget {
  const PageAccueil({super.key});

  @override
  State<PageAccueil> createState() => _PageAccueilState();
}

class _PageAccueilState extends State<PageAccueil> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyName(),
        FutureBuilder(
          future: ServiceFirestore.allPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("loading");
            }

            if (snapshot.hasData) {
              final posts = snapshot.data!;
              return ListView(
                shrinkWrap: true,
                children: posts.map(_postCard).toList(),
              );
            }
            return Text("No data");
          },
        ),
      ],
    );
  }

  Card _postCard(Post post) {
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
