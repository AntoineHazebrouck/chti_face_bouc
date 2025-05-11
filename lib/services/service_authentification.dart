import 'package:chti_face_bouc/services/service_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServiceAuthentification {
  static final instance = FirebaseAuth.instance;

  static Future<UserCredential> signin({
    required String email,
    required String password,
  }) {
    return instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<UserCredential> createAccount({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
  }) async {
    final auth = await instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await ServiceFirestore.addMember(
      id: email,
      firstname: firstname,
      lastname: lastname,
    );

    return auth;
  }

  static Future<void> signOut() {
    return instance.signOut();
  }

  // Récupérer l'id unique de l'utilisateur
  String? get myId => instance.currentUser?.uid;

  // Voir si vous êtes l'utilisateur
  bool isMe(String profileId) {
    bool result = false;
    return result;
  }
}
