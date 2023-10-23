import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseStorageService {
  static submitErrorPicture(File filePath, String errorLabel,
      String intendedCorrectLabel, String documentId) async {
    final storage = FirebaseStorage.instance;
    final folderRef = storage.ref().child('image');
    await folderRef.child("/$errorLabel/$documentId").putFile(filePath);
  }

  static Future<Widget> getImageByDocumentId(
      String documentId, String errorLabel) async {
    return Image.network(
      await FirebaseStorage.instance
          .ref()
          .child("image/$errorLabel/$documentId")
          .getDownloadURL(),
      fit: BoxFit.cover,
    );
  }
}
