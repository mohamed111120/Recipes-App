import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/core/services/register_service.dart';

import '../../constants/firebase_keys.dart';
Future<bool> checkISUser(uid) async {

  // ToDo: Firebase Firestore instance
  DatabaseService database = getIt.get<DatabaseService>();

  bool isUser = false;

  await database.firestore.collection(FirebaseKeys.usersCollection).get().then((value) {
    for (var i in value.docs) {
      if (i.data()['uid'].toString() == uid.toString()) {
        isUser = true;
        break;
      }
    }
  });
  return isUser;
}
