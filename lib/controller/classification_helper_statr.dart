import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle/constants.dart';
import 'package:recycle/main.dart';
import 'package:recycle/widgets/global_logger.dart';

class ClassificationHelperState extends ChangeNotifier {
  final Query<Map<String, dynamic>> _currentQuery = FirebaseFirestore.instance
      .collection("Image")
      .orderBy('dateTime', descending: true);
  DocumentSnapshot? _documentSnapshot;

  DocumentSnapshot? get documentSnapshot => _documentSnapshot;

  set documentSnapshot(DocumentSnapshot? value) {
    _documentSnapshot = value;
  }

  Future<void> nextImage() async {
    List<DocumentSnapshot> currentImageDocument = [];
    bool passed = true;
    do {
      passed = false;
      GlobalLogger.warn(
          "${settingBox.get("current index")} ${settingBox.get("prevDate")}");
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
        GlobalLogger.error("Error");
        break;
      }
      if (currentImageDocument.isNotEmpty) {
        settingBox.put(
            "prevDate", currentImageDocument[0]["dateTime"].toDate());
        _documentSnapshot = currentImageDocument[0];
      } else {
        GlobalLogger.log("No item in list");
        break;
      }
      passed = true;
      // we are content if it passed (no error) and not null and still waiting to be classified.
      if (passed &&
          currentImageDocument.isNotEmpty &&
          currentImageDocument[0]["totalCounter"] <
              imageClassificationSatisfactionConstant) {
        break;
      }
    } while (true);
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:recycle/constants.dart';
// import 'package:recycle/main.dart';
// import 'package:recycle/widgets/global_logger.dart';

// class ClassificationHelperState extends ChangeNotifier {
//   final Query<Map<String, dynamic>> _currentQuery = FirebaseFirestore.instance
//       .collection("Image")
//       .orderBy('dateTime', descending: true);
//   DocumentSnapshot? _documentSnapshot;

//   DocumentSnapshot? get documentSnapshot => _documentSnapshot;

//   set documentSnapshot(DocumentSnapshot? value) {
//     _documentSnapshot = value;
//   }

//   Future<List<DocumentSnapshot>?> getCurrentImageId(
//       BuildContext context) async {
//         GlobalLogger.error("running");
//     try {
//       settingBox.put("current index", settingBox.get("current index") + 1);
//       if (settingBox.get("prevDate") == null) {
//         GlobalLogger.log(1);
//         return (await _currentQuery.limit(1).get()).docs;
//       } else {
//         return (await _currentQuery
//                 .startAfter([settingBox.get("prevDate")])
//                 .limit(1)
//                 .get())
//             .docs;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   Future<void> nextImage(BuildContext context) async {
//     List<DocumentSnapshot>? currentImageDocument;
//     bool passed = true;
//     do {
//       passed = false;
//       if (context.mounted) {
//         currentImageDocument = (await getCurrentImageId(context));
//         if (currentImageDocument != null && currentImageDocument.isNotEmpty) {
//           settingBox.put(
//               "prevDate", currentImageDocument[0]["dateTIme"].toDate());
//           _documentSnapshot = currentImageDocument[0];
//         }
//         passed = true;
//       }
//       // we are content if it passed (no error) and not null and still waiting to be classified.
//       if (passed &&
//           currentImageDocument != null &&
//           currentImageDocument.isNotEmpty &&
//           currentImageDocument[0]["totalCount"] <
//               imageClassificationSatisfactionConstant) {
//         break;
//       }
//     } while (true);
//   }
// }
