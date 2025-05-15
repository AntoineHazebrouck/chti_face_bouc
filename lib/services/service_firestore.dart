import 'dart:io';

import 'package:chti_face_bouc/modeles/commentaire.dart';
import 'package:chti_face_bouc/modeles/membre.dart';
import 'package:chti_face_bouc/modeles/notif.dart';
import 'package:chti_face_bouc/modeles/post.dart';
import 'package:chti_face_bouc/services/service_authentification.dart';
import 'package:chti_face_bouc/services/service_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

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
    String? coverPictureUrl,
  }) async {
    final current = await member(id);
    await membres.doc(id).update({
      'firstname': firstname ?? current.firstname,
      'lastname': lastname ?? current.lastname,
      'description': description ?? current.description,
      'profilePictureUrl': profilePictureUrl ?? current.profilePictureUrl,
      'coverPictureUrl': coverPictureUrl ?? current.coverPictureUrl,
    });
  }

  static Future<void> updateImage({
    required File file,
    required ImageType folder,
    required String memberId,
    required String imageName,
  }) async {
    final url = await ServiceStorage.addImage(
      file: file,
      folder: folder,
      userId: memberId,
      imageName: imageName,
    );

    await ServiceFirestore.updateMember(
      id: memberId,
      profilePictureUrl: folder == ImageType.avatar ? url : null,
      coverPictureUrl: folder == ImageType.cover ? url : null,
    );
  }

  static Future<Post> post(String id) async {
    final doc = await posts.doc(id).get();
    return Post.toEntity(doc, await member(doc["member"]));
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

  static Future<List<Membre>> allMembers() async {
    final data = await membres.get();
    final mapped = data.docs.map((e) => Membre.toEntity(e)).toList();
    return mapped;
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

  static Future<void> createPost({
    required Membre member,
    required String text,
    required XFile? image,
  }) async {
    final date = DateTime.now();
    Map<String, dynamic> data = {
      "member": member.id,
      // likesKey: [],
      "date": date,
      "text": text,
    };
    if (image != null) {
      final url = await ServiceStorage.addImage(
        file: File(image.path),
        folder: ImageType.post,
        userId: member.id,
        imageName: date.toString(),
      );
      data["imageUrl"] = url;
    }
    await posts.doc().set(data);
  }

  static Future<void> addLike(Post post) async {
    final me = await ServiceFirestore.me();
    if (post.likes.contains(me.id)) {
      await post.reference.update({
        "likes": FieldValue.arrayRemove([me.id]),
      });
    } else {
      await post.reference.update({
        "likes": FieldValue.arrayUnion([me.id]),
      });
    }
  }

  static Future<void> addComment({
    required Post post,
    required String text,
  }) async {
    final memberId = (await ServiceFirestore.me()).id;
    Map<String, dynamic> map = {
      'memberId': memberId,
      'date': Timestamp.fromDate(DateTime.now()),
      'text': text,
    };
    await post.reference.collection("comments").doc().set(map);
  }

  static Future<List<Commentaire>> commentsByPost(String postId) async {
    final data =
        await posts
            .doc(postId)
            .collection("comments")
            .orderBy("date", descending: true)
            .get();
    final mapped =
        data.docs
            .map(
              (doc) async =>
                  Commentaire.toEntity(doc, await member(doc["memberId"])),
            )
            .toList();
    final result = Future.wait(mapped);
    return result;
  }

  static Future<void> sendNotification({
    required String to,
    required String text,
    required String postId,
  }) async {
    final me = await ServiceFirestore.me();

    Map<String, dynamic> map = {
      "date": Timestamp.fromDate(DateTime.now()),
      "isRead": false,
      "from": me.id,
      "text": text,
      "postId": postId,
    };
    await membres.doc(to).collection("notifications").doc().set(map);
  }

  static Future<void> markRead(Notif notification) async {
    await notification.reference.update({"isRead": true});
  }

  static Future<List<Notif>> notifications() async {
    final me = await ServiceFirestore.me();

    final data = await membres.doc(me.id).collection("notifications").get();
    final mapped = data.docs.map(Notif.toEntity).toList();
    return mapped;
  }
}
