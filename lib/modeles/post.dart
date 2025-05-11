import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final DocumentReference reference;
  final String id;
  final String member;
  final String text;
  final String? imageUrl;
  final Timestamp date;
  final List<dynamic> likes;

  Post({
    required this.reference,
    required this.id,
    required this.member,
    required this.text,
    required this.imageUrl,
    required this.date,
    required this.likes,
  });

  static Post toEntity(DocumentSnapshot document, Membre member) {
    return Post(
      reference: document.reference,
      id: document.id,
      member: document['member'],
      text: document['text'],
      imageUrl: document['imageUrl'],
      date: document['date'],
      likes: [],
    );
  }
}
