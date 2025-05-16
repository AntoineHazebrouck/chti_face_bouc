import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:chti_face_bouc/pages/common/avatar.dart';
import 'package:chti_face_bouc/services/service_date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MemberHeader extends StatelessWidget {
  final Membre member;
  final Timestamp date;

  const MemberHeader({super.key, required this.member, required this.date});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Row(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Avatar(member: member),
          Text("${member.firstname} ${member.lastname}"),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [Text(ServiceDateFormat.format(date))],
      ),
    );
  }
}
