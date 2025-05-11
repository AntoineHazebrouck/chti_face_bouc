import 'dart:io';

import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:chti_face_bouc/modeles/post.dart';
import 'package:chti_face_bouc/services/service_authentification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'service_storage.dart';

class ServiceFirestore {
  static final instance = FirebaseFirestore.instance;

  static final membres = instance.collection("members");
  static final posts = instance.collection("posts");

  static Future<void> addMember({
    required String id,
    required String firstname,
    required String lastname,
  }) {
    return membres.doc(id).set({
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
    });
  }

  //Mettre à jour un membre
  updateMember({required String id, required Map<String, dynamic> data}) {
    membres.doc(id).update(data);
  }

  //stockage et mise à jour d'une image
  updateImage({
    required File file,
    required String folder,
    required String memberId,
    required String imageName,
  }) {
    ServiceStorage()
        .addImage(
          file: file,
          folder: folder,
          userId: memberId,
          imageName: imageName,
        )
        .then((imageUrl) {
          updateMember(id: memberId, data: {imageName: imageUrl});
        });
  }

  static Future<List<Post>> allPosts() async {
    final data = await posts.orderBy("date", descending: true).get();
    final docs = data.docs;
    // .snapshots().toList();
    final mapped =
        docs.map((doc) async {
          return Post.toEntity(doc, await member(doc["member"]));
        }).toList();

    final toto = Future.wait(mapped);
    return toto;
  }

  static Future<Membre> member(String memberId) async {
    return await membres.doc(memberId).snapshots().map((snapshot) {
      return Membre.toEntity(snapshot);
    }).first;
  }

  static Future<Membre> me() async {
    final String? id = ServiceAuthentification.myEmail;
    if (id == null) {
      throw Exception("Error getting current user id");
    } else {
      return await member(id);
    }
  }
}
