import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseFirestoreService {
  // static submitErrorPicture(
  //     String errorLabel, String intendedCorrectLabel, String imageId) async {}

  // image file is randomized to firestore data path
  static submitErrorWithoutPicture(String errorLabel,
      String intendedCorrectLabel, BuildContext context) async {
    try {
      return await FirebaseFirestore.instance.collection("Image").add({
        "errorLabel": errorLabel,
        'cardboard': intendedCorrectLabel == "cardboard" ? 0 : 1,
        'glass': intendedCorrectLabel == "glass" ? 0 : 1,
        'metal': intendedCorrectLabel == "metal" ? 0 : 1,
        'paper': intendedCorrectLabel == "paper" ? 0 : 1,
        'plastic': intendedCorrectLabel == "plastic" ? 0 : 1,
        'trash': intendedCorrectLabel == "trash" ? 0 : 1,
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to upload data')));
      return null;
    }
  }
}
