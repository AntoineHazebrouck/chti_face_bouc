import 'package:cloud_firestore/cloud_firestore.dart';

class Membre {
  final DocumentReference reference;
  final String id;
  final String firstname;
  final String lastname;
  final String profilePicture;
  final String coverPicture;
  final String description;

  Membre({
    required this.reference,
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.profilePicture,
    required this.coverPicture,
    required this.description,
  });

  static Membre toEntity(DocumentSnapshot document) {
    return Membre(
      reference: document.reference,
      id: document.id,
      coverPicture: '',
      description: '',
      firstname: "",
      lastname: '',
      profilePicture: '',
    );
  }
}
