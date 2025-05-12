import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final Membre member;
  final double? size;

  const Avatar({super.key, required this.member, this.size});

  @override
  Widget build(BuildContext context) {
    return member.profilePictureUrl.isNotEmpty
        ? CircleAvatar(
          radius: size,
          backgroundImage: Image.network(member.profilePictureUrl).image,
        )
        : CircleAvatar(radius: size, child: Icon(Icons.person));
  }
}
