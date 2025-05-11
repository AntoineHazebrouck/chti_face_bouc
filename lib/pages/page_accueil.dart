import 'dart:ui';

import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:chti_face_bouc/modeles/post.dart';
import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:flutter/material.dart';

class PageAccueil extends StatefulWidget {
  const PageAccueil({super.key});

  @override
  State<PageAccueil> createState() => _PageAccueilState();
}

class _PageAccueilState extends State<PageAccueil> {
  //   late final List<Post> posts;

  // @override
  //   void initState() {
  //     super.initState();

  //     posts = ServiceFirestore.allPosts();
  //   }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ServiceFirestore.allPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("loading");
        }

        if (snapshot.hasData) {
          return ListView(
            children:
                snapshot.data!
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
    // final Membre poster = await ServiceFirestore.member(post.member).first;
    return Card.outlined(
      margin: EdgeInsets.all(10),
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
            CircleAvatar(backgroundImage: Image.network(post.imageUrl!).image),
            Text(post.member),
          ],
        ),
        trailing: Text(post.date.toDate().toIso8601String()),
      ),
    );
  }
}
