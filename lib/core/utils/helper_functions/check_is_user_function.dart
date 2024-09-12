import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/firebase_keys.dart';
Future<bool> checkISUser(uid) async {

  // ToDo: Firebase Firestore instance
  FirebaseFirestore database = FirebaseFirestore.instance;

  bool isUser = false;

  await database.collection(FirebaseKeys.usersCollection).get().then((value) {
    for (var i in value.docs) {
      if (i.data()['uid'].toString() == uid.toString()) {
        isUser = true;
        break;
      }
    }
  });
  return isUser;
}
