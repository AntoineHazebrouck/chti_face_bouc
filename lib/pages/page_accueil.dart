import 'package:chti_face_bouc/pages/common/my_name.dart';
import 'package:chti_face_bouc/pages/common/posts_list.dart';
import 'package:chti_face_bouc/pages/common/simple_future_builder.dart';
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
        SimpleFutureBuilder(
          future: ServiceFirestore.allPosts(),
          child: (posts) {
            return PostsList(posts: posts);
          },
        ),
      ],
    );
  }
}
