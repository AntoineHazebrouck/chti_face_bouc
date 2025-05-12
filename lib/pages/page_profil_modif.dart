import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:flutter/material.dart';

class PageProfilModif extends StatelessWidget {
  final TextEditingController firstname;
  final TextEditingController lastname;
  final TextEditingController description;

  PageProfilModif.from(Membre me, {super.key})
    : firstname = TextEditingController(text: me.firstname),
      lastname = TextEditingController(text: me.lastname),
      description = TextEditingController(text: me.description);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier le profil"),
        actions: [ElevatedButton(onPressed: () {}, child: Text("Valider"))],
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
              ElevatedButton(onPressed: () {}, child: Text("Se déconnecter")),
            ],
          ),
        ),
      ),
    );
  }
}
