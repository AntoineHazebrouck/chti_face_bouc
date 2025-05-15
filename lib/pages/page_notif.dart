import 'package:chti_face_bouc/pages/common/simple_future_builder.dart';
import 'package:chti_face_bouc/pages/common/widget_notif.dart';
import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:flutter/material.dart';

class PageNotif extends StatefulWidget {
  const PageNotif({super.key});

  @override
  State<PageNotif> createState() => _PageNotifState();
}

class _PageNotifState extends State<PageNotif> {
  @override
  Widget build(BuildContext context) {
    return SimpleFutureBuilder(
      future: ServiceFirestore.notifications(),
      child: (notifications) {
        return Expanded(
          child: ListView(
            children:
                notifications
                    .map(
                      (notification) => WidgetNotif(notification: notification),
                    )
                    .toList(),
          ),
        );
      },
    );
  }
}
