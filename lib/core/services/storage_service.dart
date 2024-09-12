import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadRecipeImage({
    required File imageFile,
  }) async {
    Reference fileRef = _storage.ref('recipes/photos').child(
          '${DateTime.now().toIso8601String()}${p.extension(imageFile.path)}',
        );
    UploadTask task = fileRef.putFile(imageFile);
    String? finalImage = await task.then((p) {
      if (p.state == TaskState.success) {
        return fileRef.getDownloadURL();
      }
      return null;
    });
    return finalImage;
  }

  Future<String?> uploadUserImage(
      {required File imageFile, required String uid}) async {
    Reference fileRef = _storage.ref('users/pfps').child(
          '$uid${p.extension(imageFile.path)}',
        );
    UploadTask task = fileRef.putFile(imageFile);
    String? finalImage = await task.then((p) {
      if (p.state == TaskState.success) {
        return fileRef.getDownloadURL();
      }
      return null;
    });
    return finalImage;
  }
  Future<String?> uploadChefImage(
      {required File imageFile, required String uid}) async {
    Reference fileRef = _storage.ref('chefs/pfps').child(
          '$uid${p.extension(imageFile.path)}',
        );
    UploadTask task = fileRef.putFile(imageFile);
    String? finalImage = await task.then((p) {
      if (p.state == TaskState.success) {
        return fileRef.getDownloadURL();
      }
      return null;
    });
    return finalImage;
  }

  Future<String?> uploadImageToChat({
    required File file,
    required String chatId,
  }) async {
    Reference fileRef = _storage.ref('chats/$chatId').child(
          '${DateTime.now().toIso8601String()}${p.extension(file.path)}',
        );
    UploadTask task = fileRef.putFile(file);
    String? finalImage = await task.then((p) {
      if (p.state == TaskState.success) {
        return fileRef.getDownloadURL();
      }
      return null;
    });
    return finalImage;
  }
}
