import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'user_model.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    return await getUser(userCredential.user!.uid);
  }

  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
  }) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    var data = {
      'id': userCredential.user!.uid,
      'email': email,
      'name': name,
      'createAt': DateTime.now().toUtc().toIso8601String(),
    };

    _updateUser(userCredential.user!.uid, data);

    return loginWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  _updateUser(String id, Map<String, dynamic> data) {
    return users.doc(id).set(data, SetOptions(merge: true));
  }

  Future<UserModel> getUser(String id) async {
    var doc = (await users.doc(id).get()).data() as Map<String, dynamic>;
    return UserModel.fromJson(doc);
  }
}
