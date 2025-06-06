import 'package:chti_face_bouc/modeles/post.dart';
import 'package:chti_face_bouc/pages/common/member_header.dart';
import 'package:chti_face_bouc/pages/sub_pages/page_detail_post.dart';
import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final Post parentPost;
  final bool extended;

  const PostCard({super.key, required this.parentPost, this.extended = true});

  @override
  State<PostCard> createState() => _PostCardState(post: parentPost);
}

class _PostCardState extends State<PostCard> {
  Post post;

  bool liking = false;
  bool commenting = false;

  _PostCardState({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        spacing: 10,
        children: [
          MemberHeader(member: post.member, date: post.date),
          Divider(height: 10),
          Center(
            child: Column(
              children: [
                Text(post.text),
                if (post.imageUrl != null)
                  Image.network(
                    post.imageUrl!,
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
              ],
            ),
          ),
          Visibility(
            visible: widget.extended,
            child: Column(
              children: [
                Divider(height: 10),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton.icon(
                        onPressed:
                            liking
                                ? null
                                : () async {
                                  setState(() {
                                    liking = true;
                                  });
                                  await ServiceFirestore.addLike(post);
                                  final me = await ServiceFirestore.me();
                                  await ServiceFirestore.sendNotification(
                                    to: post.memberId,
                                    text:
                                        "${me.firstname} ${me.lastname} liked your post",
                                    postId: post.id,
                                  );
                                  final updated = await ServiceFirestore.post(
                                    post.id,
                                  );
                                  setState(() {
                                    liking = false;
                                    post = updated;
                                  });
                                },
                        label: Text("${post.likes.length} Likes"),
                        icon: Icon(Icons.star_border),
                      ),
                      OutlinedButton.icon(
                        onPressed:
                            commenting
                                ? null
                                : () {
                                  setState(() {
                                    commenting = true;
                                  });

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => Scaffold(
                                            body: PageDetailPost(post: post),
                                          ),
                                    ),
                                  );

                                  setState(() {
                                    commenting = false;
                                  });
                                },
                        label: Text("Commenter"),
                        icon: Icon(Icons.chat_bubble_outline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
