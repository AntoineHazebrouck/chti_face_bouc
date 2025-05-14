import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ServiceStorage {
  static final instance = FirebaseStorage.instance;
  static final Reference ref = instance.ref();

  static Future<String> addImage({
    required File file,
    required ImageType folder,
    required String userId,
    required String imageName,
  }) async {
    final reference = ref.child(folder.name).child(userId).child(imageName);
    UploadTask task = reference.putFile(file);
    TaskSnapshot snapshot = await task.whenComplete(() => null);
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }
}

enum ImageType { post, cover, avatar }
