import 'package:chti_face_bouc/modeles/database.dart';
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

  static Membre toEntity(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Membre(
      reference: document.reference,
      id: document.id,
      coverPictureUrl: data[MembersCollection.coverPictureUrl] ?? '',
      description: data[MembersCollection.description] ?? '',
      firstname: data[MembersCollection.firstname] ?? '',
      lastname: data[MembersCollection.lastname] ?? '',
      profilePictureUrl: data[MembersCollection.profilePictureUrl] ?? '',
    );
  }
}
