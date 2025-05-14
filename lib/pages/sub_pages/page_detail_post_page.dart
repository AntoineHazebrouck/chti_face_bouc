import 'package:chti_face_bouc/modeles/post.dart';
import 'package:chti_face_bouc/pages/common/avatar.dart';
import 'package:chti_face_bouc/pages/common/post_card.dart';
import 'package:chti_face_bouc/pages/common/simple_future_builder.dart';
import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:flutter/material.dart';

class PageDetailPostPage extends StatelessWidget {
  final Post post;

  const PageDetailPostPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Commentaires")),
      body: Column(
        children: [
          PostCard(parentPost: post, extended: false),
          SimpleFutureBuilder(
            future: ServiceFirestore.commentsByPost(post.id),
            child: (data) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Row(
                      spacing: 10,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Avatar(member: post.member),
                        Text(
                          "${post.member.firstname} ${post.member.lastname}",
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 10);
                },
                itemCount: data.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
