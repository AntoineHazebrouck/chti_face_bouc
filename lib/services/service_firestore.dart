import 'dart:io';

import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:chti_face_bouc/modeles/post.dart';
import 'package:chti_face_bouc/services/service_authentification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Future<void> updateMember({
    required String id,
    String? firstname,
    String? lastname,
    String? description,
    String? profilePictureUrl,
  }) async {
    final current = await member(id);
    await membres.doc(id).update({
      'firstname': firstname ?? current.firstname,
      'lastname': lastname ?? current.lastname,
      'description': description ?? current.description,
      'profilePictureUrl': profilePictureUrl ?? current.profilePictureUrl,
    });
  }

  static updateImage({
    required File file,
    required String folder,
    required String memberId,
    required String imageName,
  }) {
    // TODO
    // ServiceStorage()
    //     .addImage(
    //       file: file,
    //       folder: folder,
    //       userId: memberId,
    //       imageName: imageName,
    //     )
    //     .then((imageUrl) {
    //       ServiceFirestore.updateMember(
    //         id: memberId,
    //         data: {imageName: imageUrl},
    //       );
    //     });
  }

  static Future<List<Post>> allPosts() async {
    final data = await posts.orderBy("date", descending: true).get();
    final docs = data.docs;
    final mapped =
        docs.map((doc) async {
          return Post.toEntity(doc, await member(doc["member"]));
        }).toList();

    final toto = Future.wait(mapped);
    return toto;
  }

  static Future<List<Post>> postsByMember(String memberId) async {
    final data = await allPosts();
    return data.where((element) => element.memberId == memberId).toList();
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
