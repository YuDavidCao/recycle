import 'dart:io';
import 'dart:math';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:recycle/constants.dart';
import 'package:recycle/custom_extensions.dart';
import 'package:recycle/main.dart';
import 'package:recycle/widgets/global_logger.dart';

class Utilities {
  static Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');
    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  static List<List<List<List<double>>>> generateRandomImageList(
      int dim1, int dim2, int dim3, int dim4) {
    Random random = Random();
    List<List<List<List<double>>>> randomList = List.generate(
        dim1,
        (_) => List.generate(
            dim2,
            (_) => List.generate(
                dim3,
                (_) =>
                    List<double>.generate(dim4, (_) => random.nextDouble()))));
    return randomList;
  }

  static testPrint() {
    GlobalLogger.log(
        dailyProgressBox.get(DateTime.now().getDateOnly().toString()));
  }

  static printStatistics() {
    for (int i = 0; i < classificationLabels.length; i++) {
      print(totalStatisticBox.get("${classificationLabels[i]}Count"));
    }
    print(totalStatisticBox.get("totalCount"));
  }

  static printDailyProgress({DateTime? dateTime}) {
    if (dateTime == null) {
      GlobalLogger.log(
          dailyProgressBox.get(DateTime.now().getDateOnly().toString()));
    } else {
      GlobalLogger.log(dailyProgressBox.get(dateTime.getDateOnly().toString()));
    }
  }
}
