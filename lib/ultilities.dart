import 'dart:io';
import 'dart:math';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class Utilities {
  static Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');
    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  List<List<List<List<double>>>> generateRandomImageList(
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
}
