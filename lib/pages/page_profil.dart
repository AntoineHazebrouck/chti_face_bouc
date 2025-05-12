import 'dart:io';

import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:chti_face_bouc/pages/common/avatar.dart';
import 'package:chti_face_bouc/pages/common/my_name.dart';
import 'package:chti_face_bouc/pages/common/posts_list.dart';
import 'package:chti_face_bouc/pages/page_profil_modif.dart';
import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PageProfil extends StatelessWidget {
  final Membre member;

  const PageProfil({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyName(),
        FutureBuilder(
          future: ServiceFirestore.me(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final me = snapshot.data!;
              return Column(
                spacing: 15,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      _cover(context, member, me),
                      _avatar(member, me),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${member.firstname} ${member.lastname}"),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageProfilModif.from(me),
                            ),
                          );
                        },
                        child: Text("Modifier mes infos"),
                      ),
                    ],
                  ),
                  Divider(height: 10),
                ],
              );
            }
            return Text("Error fetching personnal profile");
          },
        ),
        FutureBuilder(
          future: ServiceFirestore.postsByMember(member.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final posts = snapshot.data!;
              return PostsList(posts: posts);
            }
            return Text("No data");
          },
        ),
      ],
    );
  }

  Widget _photoSelector(Membre selected, Membre me, String imageUrl) {
    _takePicture(ImageSource source, String name) async {
      final XFile? xFile = await ImagePicker().pickImage(
        source: source,
        maxWidth: 500,
      );
      if (xFile == null) return;
      ServiceFirestore.updateImage(
        file: File(xFile.path),
        folder: "members",
        memberId: me.id,
        imageName: name,
      );
    }

    return Visibility(
      visible: selected.id == me.id,
      child: ElevatedButton(
        onPressed: () {
          _takePicture(ImageSource.gallery, imageUrl);
        },
        child: Icon(Icons.photo),
      ),
    );
  }

  Widget _cover(BuildContext context, Membre selected, Membre me) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
          child: Image.network(selected.coverPictureUrl, fit: BoxFit.cover),
        ),
        // TODO check on phone
        _photoSelector(selected, me, me.coverPictureUrl),
      ],
    );
  }

  Widget _avatar(Membre selected, Membre me) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Avatar(member: selected, size: 55),
        // TODO check on phone
        _photoSelector(selected, me, me.profilePictureUrl),
      ],
    );
  }
}
