import 'package:chti_face_bouc/pages/common/my_name.dart';
import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:flutter/material.dart';

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
              return Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.red,
                    child: Image.network(
                      snapshot.data!.coverPictureUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  CircleAvatar(backgroundColor: Colors.blue, radius: 50),
                ],
              );
            }
            return Text("Error fetching personnal profile");
          },
        ),
      ],
    );
  }
}
