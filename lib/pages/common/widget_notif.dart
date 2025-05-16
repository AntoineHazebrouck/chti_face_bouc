import 'package:chti_face_bouc/pages/common/simple_future_builder.dart';
import 'package:chti_face_bouc/pages/sub_pages/page_detail_post.dart';
import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:flutter/material.dart';

import '../../modeles/notif.dart';

class WidgetNotif extends StatelessWidget {
  final Notif notification;

  WidgetNotif({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ServiceFirestore.markRead(notification);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder:
                (context) => SimpleFutureBuilder(
                  future: ServiceFirestore.post(notification.postId),
                  child: (post) => PageDetailPost(post: post),
                ),
          ),
        );
      },
      child: Container(
        color:
            notification.isRead
                ? Colors.green.withValues(alpha: 0.3)
                : Colors.red.withValues(alpha: 0.3),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 5, right: 5),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // MemberHeader(
            //   memberId: notif.from,
            //   date: notif.date,
            // ),
            Text(notification.text),
          ],
        ),
      ),
    );
  }
}
