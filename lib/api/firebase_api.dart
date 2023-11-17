import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      final task = ref.putFile(file);
      return task;
    } on FirebaseException catch (e) {
      print('Firebase Storage Error: $e');
      return null;
    }
  }
}
