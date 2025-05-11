import 'package:cloud_firestore/cloud_firestore.dart';

class Membre {
  final DocumentReference reference;
  final String id;
  final String firstname;
  final String lastname;
  final String profilePictureUrl;
  final String coverPictureUrl;
  final String description;

  Membre({
    required this.reference,
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.profilePictureUrl,
    required this.coverPictureUrl,
    required this.description,
  });

  static Membre toEntity(DocumentSnapshot document) {
    return Membre(
      reference: document.reference,
      id: document.id,
      coverPictureUrl: document["coverPictureUrl"] ?? '',
      description: '',
      firstname: document["firstname"] ?? '',
      lastname: document["lastname"] ?? '',
      profilePictureUrl: document["profilePictureUrl"] ?? '',
    );
  }
}
