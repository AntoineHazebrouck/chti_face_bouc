import 'package:chti_face_bouc/pages/common/avatar.dart';
import 'package:chti_face_bouc/pages/common/simple_future_builder.dart';
import 'package:chti_face_bouc/pages/page_profil.dart';
import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:flutter/material.dart';

class PageMembers extends StatelessWidget {
  const PageMembers({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleFutureBuilder(
      future: ServiceFirestore.allMembers(),
      child: (members) {
        return Expanded(
          child: ListView(
            children:
                members
                    .map(
                      (member) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => Scaffold(
                                      appBar: AppBar(
                                        title: Text("Voir le profil"),
                                      ),
                                      body: PageProfil(memberId: member.id),
                                    ),
                              ),
                            );
                          },
                          leading: Row(
                            spacing: 15,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Avatar(member: member),
                              Text("${member.firstname} ${member.lastname}"),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        );
      },
    );
  }
}
