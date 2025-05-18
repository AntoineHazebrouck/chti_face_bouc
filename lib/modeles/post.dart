import 'package:chti_face_bouc/modeles/database.dart';
import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final DocumentReference reference;
  final String id;
  final String memberId;
  final String text;
  final String? imageUrl;
  final Timestamp date;
  final List<String> likes; // member ids
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
      memberId: data[PostsCollection.memberId],
      text: data[PostsCollection.text],
      imageUrl: data[PostsCollection.imageUrl],
      date: data[PostsCollection.date],
      likes:
          ((data[PostsCollection.likes] ?? <String>[]) as List).cast<String>(),
      member: membre,
    );
  }
}
