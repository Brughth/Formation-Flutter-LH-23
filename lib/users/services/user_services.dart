import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserServices {
  CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection("personnes");

  Future<DocumentReference<Map<String, dynamic>>> addUser(
      {required Map<String, dynamic> data}) async {
    data['createAt'] = DateTime.now().toUtc().toIso8601String();
    var userRef = await users.add(data);
    return userRef;
  }

  updateUser({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    data['updateAt'] = DateTime.now().toUtc().toIso8601String();
    await users.doc(id).set(data, SetOptions(merge: true));
  }

  deleteUser({required String id}) async {
    await users.doc(id).delete();
  }

  Future<String> uploadFileToFirebaseAndGetDownloadURL(
      {required File image}) async {
    Reference ref = FirebaseStorage.instance.ref();

    TaskSnapshot upload =
        await ref.child("images/${image.hashCode}.jpg").putFile(image);

    return await upload.ref.getDownloadURL();
  }
}
