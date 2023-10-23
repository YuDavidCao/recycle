import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle/constants.dart';

class ClassificationHelperState extends ChangeNotifier {
  int currentIndex = 0;
  DateTime? prevDateTime;
  Query<Map<String, dynamic>> _currentQuery = FirebaseFirestore.instance
      .collection("Image")
      .orderBy('dateTime', descending: true);

  Future<List<DocumentSnapshot>> getCurrentImageId() async {
    if (prevDateTime == null) {
      return (await _currentQuery.limit(1).get()).docs;
    } else {
      return (await _currentQuery.startAfter([prevDateTime]).limit(1).get())
          .docs;
    }
  }

  Future<void> filterImage() async {
    DocumentSnapshot currentImageDocument = (await getCurrentImageId())[0];
    prevDateTime = currentImageDocument["dateTIme"].toDate();
    while (currentImageDocument["totalCount"] <
        imageClassificationSatisfactionConstant) {
      currentImageDocument = (await getCurrentImageId())[0];
      prevDateTime = currentImageDocument["dateTIme"].toDate();
    }
  }
}
