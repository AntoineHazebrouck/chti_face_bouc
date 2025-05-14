import 'package:chti_face_bouc/pages/common/my_name.dart';
import 'package:chti_face_bouc/pages/common/posts_list.dart';
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
        // TODO
        FutureBuilder(
          future: ServiceFirestore.allPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("loading");
            }

            if (snapshot.hasData) {
              final posts = snapshot.data!;
              return PostsList(posts: posts);
            }
            return Text("No data");
          },
        ),
      ],
    );
  }
}
