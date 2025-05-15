import 'package:chti_face_bouc/modeles/post.dart';
import 'package:chti_face_bouc/pages/common/avatar.dart';
import 'package:chti_face_bouc/pages/common/post_card.dart';
import 'package:chti_face_bouc/pages/common/simple_future_builder.dart';
import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:flutter/material.dart';

class PageDetailPostPage extends StatefulWidget {
  final Post post;

  const PageDetailPostPage({super.key, required this.post});

  @override
  State<PageDetailPostPage> createState() => _PageDetailPostPageState();
}

class _PageDetailPostPageState extends State<PageDetailPostPage> {
  final TextEditingController comment = TextEditingController();

  bool commenting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Commentaires")),
      body: Column(
        spacing: 10,
        children: [
          PostCard(parentPost: widget.post, extended: false),
          LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: comment,
                    decoration: InputDecoration(
                      label: Text("Commentaire"),
                      constraints: constraints * 0.7,
                    ),
                  ),
                  IconButton(
                    onPressed:
                        commenting
                            ? null
                            : () async {
                              setState(() {
                                commenting = true;
                              });
                              await ServiceFirestore.addComment(
                                post: widget.post,
                                text: comment.text,
                              );

                              setState(() {
                                commenting = false;
                              });
                            },
                    icon: Icon(Icons.send),
                  ),
                ],
              );
            },
          ),
          SimpleFutureBuilder(
            future: ServiceFirestore.commentsByPost(widget.post.id),
            child: (data) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Row(
                      spacing: 10,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Avatar(member: widget.post.member),
                        Text(
                          "${widget.post.member.firstname} ${widget.post.member.lastname}",
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
