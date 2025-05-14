import 'dart:io';

import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:chti_face_bouc/pages/common/avatar.dart';
import 'package:chti_face_bouc/pages/common/posts_list.dart';
import 'package:chti_face_bouc/pages/common/simple_future_builder.dart';
import 'package:chti_face_bouc/pages/sub_pages/page_profil_modif.dart';
import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:chti_face_bouc/services/service_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PageProfil extends StatefulWidget {
  final String memberId;

  const PageProfil({super.key, required this.memberId});

  @override
  State<PageProfil> createState() => _PageProfilState();
}

class _PageProfilState extends State<PageProfil> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SimpleFutureBuilder(
          future: ServiceFirestore.me(),
          child: (me) {
            return Column(
              spacing: 15,
              children: [
                SimpleFutureBuilder(
                  future: ServiceFirestore.member(widget.memberId),
                  child: (member) {
                    return Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        _cover(context, member, me),
                        _avatar(member, me),
                      ],
                    );
                  },
                ),
                Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SimpleFutureBuilder(
                      future: ServiceFirestore.member(widget.memberId),
                      child: (member) {
                        return Text("${member.firstname} ${member.lastname}");
                      },
                    ),
                    if (me.id == widget.memberId)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageProfilModif.from(me),
                            ),
                          ).then((value) {
                            setState(() {});
                          });
                        },
                        child: Text("Modifier mes infos"),
                      ),
                  ],
                ),
                Divider(height: 10),
              ],
            );
          },
        ),
        SimpleFutureBuilder(
          future: ServiceFirestore.postsByMember(widget.memberId),
          child: (posts) => PostsList(posts: posts),
        ),
      ],
    );
  }

  Future<void> _takePicture(
    ImageSource source,
    ImageType folder,
    String memberId,
  ) async {
    final XFile? xFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: 500,
    );
    if (xFile == null) return;
    await ServiceFirestore.updateImage(
      file: File(xFile.path),
      folder: folder,
      memberId: memberId,
      imageName: xFile.name,
    );
  }

  Widget _photoSelector(Membre selected, Membre me, ImageType folder) {
    return Visibility(
      visible: selected.id == me.id,
      child: ElevatedButton(
        onPressed: () {
          _takePicture(ImageSource.gallery, folder, me.id).then((value) {
            setState(() {});
          });
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
          color: Colors.blueGrey,
          child:
              selected.coverPictureUrl.isEmpty
                  ? Icon(Icons.person)
                  : Image.network(selected.coverPictureUrl, fit: BoxFit.cover),
        ),
        // TODO check on phone
        _photoSelector(selected, me, ImageType.cover),
      ],
    );
  }

  Widget _avatar(Membre selected, Membre me) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Avatar(member: selected, size: 55),
        // TODO check on phone
        _photoSelector(selected, me, ImageType.avatar),
      ],
    );
  }
}
