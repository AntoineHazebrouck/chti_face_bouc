import 'package:cloud_firestore/cloud_firestore.dart';

class Notif {
  final DocumentReference reference;
  final String id;
  final String from;
  final String text;
  final Timestamp date;
  final bool isRead;
  final String postId;

  Notif({
    required this.from,
    required this.text,
    required this.date,
    required this.isRead,
    required this.postId,
    required this.reference,
    required this.id,
  });

  static Notif toEntity(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Notif(
      reference: document.reference,
      id: document.id,
      date: data['date'],
      from: data['from'],
      isRead: data['isRead'],
      text: data['text'],
      postId: data['postId'],
    );
  }
}
