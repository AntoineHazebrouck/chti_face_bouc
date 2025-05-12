import 'dart:io';

import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:chti_face_bouc/pages/common/avatar.dart';
import 'package:chti_face_bouc/pages/common/my_name.dart';
import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PageProfil extends StatefulWidget {
  const PageProfil({super.key});

  @override
  State<PageProfil> createState() => _PageProfilState();
}

class _PageProfilState extends State<PageProfil> {
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
                    children: [_cover(context, me), _avatar(me)],
                  ),
                  Text("${me.firstname} ${me.lastname}"),
                  Divider(height: 10),
                ],
              );
            }
            return Text("Error fetching personnal profile");
          },
        ),
      ],
    );
  }

  Widget _photoSelector(Membre me, String imageUrl) {
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

    return ElevatedButton(
      onPressed: () {
        _takePicture(ImageSource.gallery, imageUrl);
      },
      child: Icon(Icons.photo),
    );
  }

  Widget _cover(BuildContext context, Membre me) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
          child: Image.network(me.coverPictureUrl, fit: BoxFit.cover),
        ),
        _photoSelector(me, me.coverPictureUrl),
      ],
    );
  }

  Widget _avatar(Membre me) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Avatar(member: me, size: 55),
        _photoSelector(me, me.profilePictureUrl),
      ],
    );
  }
}
