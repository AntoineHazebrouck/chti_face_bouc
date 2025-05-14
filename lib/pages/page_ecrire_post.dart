import 'dart:io';

import 'package:chti_face_bouc/pages/common/my_name.dart';
import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PageEcrirePost extends StatefulWidget {
  const PageEcrirePost({super.key});

  @override
  State<PageEcrirePost> createState() => _PageEcrirePostState();
}

class _PageEcrirePostState extends State<PageEcrirePost> {
  final TextEditingController post = TextEditingController();
  XFile? image;

  Future<void> pickImage(ImageSource source) async {
    final selected = await ImagePicker().pickImage(source: source);
    setState(() {
      image = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MyName(),
          Card.outlined(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              spacing: 10,
              children: [
                ListTile(
                  trailing: Row(
                    spacing: 10,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.border_color),
                      Text("Ecrire un post"),
                    ],
                  ),
                ),
                Divider(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    controller: post,
                    decoration: InputDecoration(label: Text("Votre post")),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () => pickImage(ImageSource.gallery),
                      icon: Icon(Icons.photo_album),
                    ),
                    IconButton(
                      onPressed: () => pickImage(ImageSource.camera),
                      icon: Icon(Icons.photo_camera),
                    ),
                  ],
                ),
                if (image != null)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.file(File(image!.path)),
                  ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () async {
              final me = await ServiceFirestore.me();
              ServiceFirestore.createPost(
                member: me,
                text: post.text,
                image: image,
              );
            },
            child: Text("Envoyer"),
          ),
        ],
      ),
    );
  }
}
