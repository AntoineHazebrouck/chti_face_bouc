import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:flutter/material.dart';

class MemberBuilder extends StatelessWidget {
  final String memberId;
  final Widget Function(Membre member) child;

  const MemberBuilder({super.key, required this.memberId, required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ServiceFirestore.member(memberId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final member = snapshot.data!;
          return child(member);
        }
        return Text("Error fetching member data");
      },
    );
  }
}
