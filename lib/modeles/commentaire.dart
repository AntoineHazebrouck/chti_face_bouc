import 'package:chti_face_bouc/modeles/database.dart';
import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Commentaire {
  final DocumentReference reference;
  final String id;
  final String memberId;
  final Membre member;
  final String text;
  final Timestamp date;

  Commentaire({
    required this.memberId,
    required this.member,
    required this.text,
    required this.date,
    required this.reference,
    required this.id,
  });

  static Commentaire toEntity(
    DocumentSnapshot<Map<String, dynamic>> document,
    Membre member,
  ) {
    final data = document.data()!;
    return Commentaire(
      member: member,
      memberId: data[CommentsCollection.memberId],
      text: data[CommentsCollection.text],
      date: data[CommentsCollection.date],
      reference: document.reference,
      id: document.id,
    );
  }
}
