import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection("users");

  Future<DocumentReference<Map<String, dynamic>>> addUser(
      {required Map<String, dynamic> data}) async {
    data['createAt'] = DateTime.now().toUtc().toIso8601String();
    var userRef = await users.add(data);
    return userRef;
  }

  void updateUser({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    data['updateAt'] = DateTime.now().toUtc().toIso8601String();
    await users.doc(id).set(data, SetOptions(merge: true));
  }

  void deleteUser({required String id}) async {
    await users.doc(id).delete();
  }
}
