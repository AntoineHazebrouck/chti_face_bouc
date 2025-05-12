import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:chti_face_bouc/services/service_authentification.dart';
import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:flutter/material.dart';

class PageProfilModif extends StatelessWidget {
  final Membre me;
  final TextEditingController firstname;
  final TextEditingController lastname;
  final TextEditingController description;

  PageProfilModif.from(this.me, {super.key})
    : firstname = TextEditingController(text: me.firstname),
      lastname = TextEditingController(text: me.lastname),
      description = TextEditingController(text: me.description);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier le profil"),
        actions: [
          ElevatedButton(
            onPressed: () {
              ServiceFirestore.updateMember(
                id: me.id,
                firstname: firstname.text,
                lastname: lastname.text,
                description: description.text,
              ).then((value) {
                if (context.mounted) Navigator.pop(context);
              });
              ;
            },
            child: Text("Valider"),
          ),
        ],
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            spacing: 10,

            children: [
              TextField(
                decoration: InputDecoration(label: Text("Prénom")),
                controller: firstname,
              ),
              TextField(
                decoration: InputDecoration(label: Text("Nom")),
                controller: lastname,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(label: Text("Description")),
                controller: description,
              ),
              ElevatedButton(
                onPressed: () {
                  ServiceAuthentification.signOut().then((value) {
                    if (context.mounted) Navigator.pop(context);
                  });
                },
                child: Text("Se déconnecter"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
