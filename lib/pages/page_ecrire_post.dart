import 'package:chti_face_bouc/pages/common/my_name.dart';
import 'package:flutter/material.dart';

class PageEcrirePost extends StatefulWidget {
  const PageEcrirePost({super.key});

  @override
  State<PageEcrirePost> createState() => _PageEcrirePostState();
}

class _PageEcrirePostState extends State<PageEcrirePost> {
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
                    decoration: InputDecoration(label: Text("Votre post")),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.photo_album)),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.photo_camera),
                    ),
                  ],
                ),
                // Image.asset("resources/images/flutter_logo.png")
              ],
            ),
          ),
          OutlinedButton(onPressed: () {}, child: Text("Envoyer")),
        ],
      ),
    );
  }
}
