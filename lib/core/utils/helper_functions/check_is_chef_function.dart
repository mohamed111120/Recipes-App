import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/firebase_keys.dart';
import '../../services/register_service.dart';

Future<bool> checkISChef(uid) async {

  FirebaseFirestore database = FirebaseFirestore.instance;

  bool isChef = false;

  await database.collection(FirebaseKeys.chefsCollection).get().then((value) {
    for (var i in value.docs) {
      if (i.data()['uid'].toString() == uid.toString()) {
        isChef = true;
        break;
      }
    }
  });
  return isChef;
}
