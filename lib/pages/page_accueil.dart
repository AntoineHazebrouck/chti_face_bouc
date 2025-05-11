import 'package:chti_face_bouc/modeles/post.dart';
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
    return FutureBuilder(
      future: ServiceFirestore.allPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("loading");
        }

        if (snapshot.hasData) {
          final posts = snapshot.data!;
          return ListView(
            children:
                posts
                    // TODO faire les jointures avec le joueur
                    .map(_postCard)
                    .toList(),
          );
        }
        return Text("No data");
      },
    );
  }

  Card _postCard(Post post) {
    return Card.outlined(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListTile(
        subtitle: Center(
          child: Column(
            children: [
              Text(post.text),
              if (post.imageUrl != null) Image.network(post.imageUrl!),
            ],
          ),
        ),
        leading: Row(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            post.member.profilePictureUrl.isNotEmpty
                ? CircleAvatar(
                  backgroundImage:
                      Image.network(post.member.profilePictureUrl).image,
                )
                : CircleAvatar(child: Icon(Icons.person)),
            Text("${post.member.firstname} ${post.member.lastname}"),
          ],
        ),
        trailing: Text(post.date.toDate().toIso8601String()),
      ),
    );
  }
}
