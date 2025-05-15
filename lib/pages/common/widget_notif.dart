import 'package:flutter/material.dart';
import '../../modeles/notif.dart';

class WidgetNotif extends StatelessWidget {
  final Notif notification;

  const WidgetNotif({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // ServiceFirestore()
        //     .firestorePost
        //     .doc(notif.postId)
        //     .get()
        //     .then((snapshot) {
        //   ServiceFirestore().markRead(notif.reference);
        //   final post = Post(
        //     reference: snapshot.reference,
        //     id: snapshot.id,
        //     map: snapshot.data() as Map<String, dynamic>,
        //     // Post
        //   );
        //   Navigator.of(context).push(
        //     MaterialPageRoute(builder: (context) {
        //       return PageDetailPost(post: post);
        //     }), // MaterialPageRoute
        //   );
        // });
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
