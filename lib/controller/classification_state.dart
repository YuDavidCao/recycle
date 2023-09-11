import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recycle/constants.dart';

import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

import 'package:image/image.dart' as Img;

import 'dart:math';

typedef Model = tfl.Interpreter;

String modelPath = 'assets/model.tflite';

class ClassificationState extends ChangeNotifier {
  Model? model;

  Future<void> loadModel() async {
    model = await tfl.Interpreter.fromAsset(modelPath);
  }

  List<List<List<List<double>>>> generateRandomList(
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

  Future<String> predict(Img.Image image) async {
    if (model == null) {
      await loadModel();
    }
    final List<List<List<num>>> shapedList = List.generate(
      classificiationHeight,
      (y) => List.generate(
        classificationWidth,
        (x) {
          final pixel = image.getPixel(x, y);
          return [pixel.r, pixel.g, pixel.b];
        },
      ),
    );
    List<dynamic> output = [
      List.generate(classificationLabels.length, (_) => 0)
    ];
    model?.run([shapedList], output);
    return decodeLabel(output);
  }

  String decodeLabel(List<dynamic> rawOutput) {
    int maxIndex = 0;
    double maxValue = rawOutput[0][0];
    for (int i = 1; i < classificationLabels.length; i++) {
      if (rawOutput[0][i] > maxValue) {
        maxValue = rawOutput[0][i];
        maxIndex = i;
      }
    }
    return classificationLabels[maxIndex];
  }
}
