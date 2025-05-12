import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:chti_face_bouc/pages/common/simple_future_builder.dart';
import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:flutter/material.dart';

class MyName extends StatelessWidget {
  const MyName({super.key});

  @override
  Widget build(BuildContext context) {
    // return SimpleFutureBuilder(future: memberId, child: child)
    
    return FutureBuilder(
      future: ServiceFirestore.me(),
      builder: (BuildContext context, AsyncSnapshot<Membre> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("loading");
        }

        if (snapshot.hasData) {
          final me = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "${me.firstname} ${me.lastname}",
                style: TextStyle(fontSize: 30),
              ),
            ),
          );
        }
        return Text("No data");
      },
    );
  }
}
