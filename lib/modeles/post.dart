import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final DocumentReference reference;
  final String id;
  final String memberId;
  final String text;
  final String? imageUrl;
  final Timestamp date;
  final List<dynamic> likes;
  final Membre member;

  Post({
    required this.reference,
    required this.id,
    required this.memberId,
    required this.text,
    required this.imageUrl,
    required this.date,
    required this.likes,
    required this.member,
  });

  static Post toEntity(DocumentSnapshot document, Membre membre) {
    return Post(
      reference: document.reference,
      id: document.id,
      memberId: document['member'],
      text: document['text'],
      imageUrl: document['imageUrl'],
      date: document['date'],
      likes: [],
      member: membre,
    );
  }
}
