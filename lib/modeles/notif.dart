import 'package:chti_face_bouc/modeles/database.dart';
import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notif {
  final DocumentReference reference;
  final String id;
  final String from;
  final Membre sender;
  final String text;
  final Timestamp date;
  final bool isRead;
  final String postId;

  Notif({
    required this.sender,
    required this.from,
    required this.text,
    required this.date,
    required this.isRead,
    required this.postId,
    required this.reference,
    required this.id,
  });

  static Notif toEntity(
    DocumentSnapshot<Map<String, dynamic>> document,
    Membre sender,
  ) {
    final data = document.data()!;
    return Notif(
      reference: document.reference,
      id: document.id,
      sender: sender,
      date: data[NotifsCollection.date],
      from: data[NotifsCollection.from],
      isRead: data[NotifsCollection.isRead],
      text: data[NotifsCollection.text],
      postId: data[NotifsCollection.postId],
    );
  }
}
