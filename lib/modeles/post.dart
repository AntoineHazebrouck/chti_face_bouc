import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final DocumentReference reference;
  final String id;
  final String memberId;
  final String text;
  final String? imageUrl;
  final Timestamp date;
  final List<Membre> likes;
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

  static Post toEntity(
    DocumentSnapshot<Map<String, dynamic>> document,
    Membre membre,
  ) {
    final data = document.data()!;
    return Post(
      reference: document.reference,
      id: document.id,
      memberId: data['member'],
      text: data['text'],
      imageUrl: data['imageUrl'],
      date: data['date'],
      likes: [],
      member: membre,
    );
  }
}
