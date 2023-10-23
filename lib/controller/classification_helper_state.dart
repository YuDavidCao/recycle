import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle/constants.dart';
import 'package:recycle/main.dart';
import 'package:recycle/widgets/global_logger.dart';

class ClassificationHelperState extends ChangeNotifier {
  final Query<Map<String, dynamic>> _currentQuery = FirebaseFirestore.instance
      .collection("Image")
      .orderBy('dateTime', descending: false);
  DocumentSnapshot? _documentSnapshot;
  bool noMoreImages = false;

  DocumentSnapshot? get documentSnapshot => _documentSnapshot;

  set documentSnapshot(DocumentSnapshot? value) {
    _documentSnapshot = value;
  }

  Future<void> nextImage(BuildContext context) async {
    List<DocumentSnapshot> currentImageDocument = [];
    bool passed = true;
    do {
      passed = false;
      try {
        if (settingBox.get("prevDate") == null) {
          currentImageDocument = (await _currentQuery.limit(1).get()).docs;
        } else {
          currentImageDocument = (await _currentQuery
                  .startAfter([settingBox.get("prevDate")])
                  .limit(1)
                  .get())
              .docs;
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error fetching data')));
        }
        break;
      }
      if (currentImageDocument.isNotEmpty) {
        settingBox.put(
            "prevDate", currentImageDocument.first["dateTime"].toDate());
        _documentSnapshot = currentImageDocument.first;
      } else {
        noMoreImages = true;
        notifyListeners();
        break;
      }
      passed = true;
      // we are content if it passed (no error) and not null and still waiting to be classified.
      if (passed &&
          currentImageDocument.isNotEmpty &&
          currentImageDocument.first["totalCounter"] <
              imageClassificationSatisfactionConstant) {
        notifyListeners();
        break;
      }
    } while (true);
  }
}
