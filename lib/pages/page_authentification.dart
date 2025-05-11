import 'package:chti_face_bouc/services/service_authentification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PageAuthentification extends StatefulWidget {
  const PageAuthentification({super.key});

  @override
  State<PageAuthentification> createState() => _PageAuthentificationState();
}

class _PageAuthentificationState extends State<PageAuthentification> {
  bool _register = true;

  String? authenticationError;
  String? authenticationSuccessMessage;

  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              spacing: 10,
              children: [
                Image.asset("resources/images/jul.jpg"),
                SegmentedButton<bool>(
                  segments: [
                    ButtonSegment(
                      value: true,
                      icon: Icon(Icons.app_registration),
                      label: Text("Créer t'in compte"),
                    ),
                    ButtonSegment(
                      value: false,
                      icon: Icon(Icons.login),
                      label: Text("y va connecter"),
                    ),
                  ],
                  selected: {_register},
                  onSelectionChanged: (selection) {
                    setState(() {
                      _register = selection.first;
                    });
                  },
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      spacing: 10,

                      children: [
                        TextField(
                          decoration: InputDecoration(
                            label: Text("Adresse mail"),
                          ),
                          controller: _mailController,
                        ),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            label: Text("Mot de passe"),
                          ),
                          controller: _passwordController,
                        ),
                        if (_register)
                          TextField(
                            decoration: InputDecoration(label: Text("Prénom")),
                            controller: _firstnameController,
                          ),
                        if (_register)
                          TextField(
                            decoration: InputDecoration(label: Text("Nom")),
                            controller: _lastnameController,
                          ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    handleAuthenticationError(
                      FirebaseAuthException error,
                      stacktrace,
                    ) {
                      setState(() {
                        authenticationError = error.message;
                      });
                    }

                    handleAuthenticationSuccess(message) {
                      setState(() {
                        authenticationError = null;
                        authenticationSuccessMessage = message;
                      });
                    }

                    if (_register) {
                      ServiceAuthentification.createAccount(
                            email: _mailController.text,
                            password: _passwordController.text,
                            firstname: _firstnameController.text,
                            lastname: _lastnameController.text,
                          )
                          .then(
                            (value) => handleAuthenticationSuccess(
                              "Compte créé avec le mail suivant : ${value.user!.email!}",
                            ),
                          )
                          .onError(handleAuthenticationError);
                    } else {
                      ServiceAuthentification.signin(
                            email: _mailController.text,
                            password: _passwordController.text,
                          )
                          .then(
                            (value) => handleAuthenticationSuccess(
                              "Connecté avec le mail suivant : ${value.user!.email!}",
                            ),
                          )
                          .onError(handleAuthenticationError);
                    }
                  },
                  child: Text("C'est parti !"),
                ),
                Visibility(
                  visible: authenticationSuccessMessage != null,
                  child: Text(
                    authenticationSuccessMessage ?? "Should not happen",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                Visibility(
                  visible: authenticationError != null,
                  child: Text(
                    authenticationError ?? "Should not happen",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mailController.dispose();
    _passwordController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }
}
