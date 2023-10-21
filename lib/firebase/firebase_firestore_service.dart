import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseFirestoreService {
  // static submitErrorPicture(
  //     String errorLabel, String intendedCorrectLabel, String imageId) async {}

  // image file is randomized to firestore data path
  static Future<DocumentReference?> submitErrorWithoutPicture(String errorLabel,
      String intendedCorrectLabel, BuildContext context) async {
    try {
      return await FirebaseFirestore.instance.collection("Image").add({
        "errorLabel": errorLabel,
        'cardboard': intendedCorrectLabel == "cardboard" ? 1 : 0,
        'glass': intendedCorrectLabel == "glass" ? 1 : 0,
        'metal': intendedCorrectLabel == "metal" ? 1 : 0,
        'paper': intendedCorrectLabel == "paper" ? 1 : 0,
        'plastic': intendedCorrectLabel == "plastic" ? 1 : 0,
        'trash': intendedCorrectLabel == "trash" ? 1 : 0,
        'totalCounter': 1,
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to upload data')));
      return null;
    }
  }

  static Future<void> submitErroredPictureLabel(String documentId,
      BuildContext context, String intendedCorrectLabel) async {
    try {
      FirebaseFirestore.instance.collection("Image").doc(documentId).update({
        intendedCorrectLabel: FieldValue.increment(1),
        'totalCounter': FieldValue.increment(1),
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to upload data')));
    }
  }
}
