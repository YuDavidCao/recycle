import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static submitErrorPicture(File filePath, String errorLabel,
      String intendedCorrectLabel, String documentId) async {
    final storage = FirebaseStorage.instance;
    final folderRef = storage.ref().child('image');
    await folderRef.child("/$errorLabel/$documentId").putFile(filePath);
  }
}
