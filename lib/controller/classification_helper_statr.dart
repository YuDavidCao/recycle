import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle/constants.dart';
import 'package:recycle/main.dart';

class ClassificationHelperState extends ChangeNotifier {
  final Query<Map<String, dynamic>> _currentQuery = FirebaseFirestore.instance
      .collection("Image")
      .orderBy('dateTime', descending: true);

  Future<List<DocumentSnapshot>?> getCurrentImageId(
      BuildContext context) async {
    try {
      settingBox.put("current index", settingBox.get("current index"));
      if (settingBox.get("prevDate") == null) {
        return (await _currentQuery.limit(1).get()).docs;
      } else {
        return (await _currentQuery
                .startAfter([settingBox.get("prevDate")])
                .limit(1)
                .get())
            .docs;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed fetch image')));
      return null;
    }
  }

  Future<void> filterImage(BuildContext context) async {
    List<DocumentSnapshot>? currentImageDocument =
        (await getCurrentImageId(context));
    if (currentImageDocument != null) {
      settingBox.put("prevDate", currentImageDocument[0]["dateTIme"].toDate());
      bool passed = true;
      while (true) {
        passed = false;
        if (context.mounted) {
          currentImageDocument = (await getCurrentImageId(context));
          if (currentImageDocument != null) {
            settingBox.put(
                "prevDate", currentImageDocument[0]["dateTIme"].toDate());
          }
          passed = true;
        } 
        // we are content if it passed (no error) and not null and still waiting to be classified.
        if (passed &&
            currentImageDocument != null &&
            currentImageDocument[0]["totalCount"] <
                imageClassificationSatisfactionConstant) {
          break;
        }
      }
    }
  }
}
