import 'package:chti_face_bouc/modeles/post.dart';
import 'package:chti_face_bouc/pages/common/post_card.dart';
import 'package:flutter/material.dart';

class PostsList extends StatelessWidget {
  final List<Post> posts;

  const PostsList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: posts.map((post) => PostCard(post: post)).toList(),
      ),
    );
  }
}
