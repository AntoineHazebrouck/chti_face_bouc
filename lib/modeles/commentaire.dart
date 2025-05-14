import 'package:cloud_firestore/cloud_firestore.dart';

class Commentaire {
  final DocumentReference reference;
  final String id;
  final String memberId;
  final String text;
  final Timestamp date;

  Commentaire({
    required this.memberId,
    required this.text,
    required this.date,
    required this.reference,
    required this.id,
  });

  static Commentaire toEntity(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Commentaire(
      memberId: data['memberId'],
      text: data['text'],
      date: data['date'],
      reference: document.reference,
      id: document.id,
    );
  }
}
