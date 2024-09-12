import 'package:firebase_auth/firebase_auth.dart';

import '../constants/shared_keys.dart';
import 'cache/shered_manager.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _uid = SharedService.get(key: SharedKeys.uid);

  String? get uid {
    return _uid;
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await SharedService.set(
          key: SharedKeys.uid,
          value: userCredential.user!.uid,
        ).then(
          (value) {
            _uid = SharedService.get(key: SharedKeys.uid);
          },
        );

        return true;
      }
    } on Exception catch (e) {
      // TODO: Handle exception
      print(e);
    }
    return false;
  }

  Future<bool> logout() async {
    try {
      await _auth.signOut().then(
        (value) {
          SharedService.remove(key: SharedKeys.uid);
        },
      );

      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
       await  SharedService.set(
          key: SharedKeys.uid,
          value: userCredential.user!.uid,
        ).then(
          (value) {
            _uid = SharedService.get(key: SharedKeys.uid);
          },
        );
      }
    } on Exception catch (e) {
      rethrow;
    }
  }
}
