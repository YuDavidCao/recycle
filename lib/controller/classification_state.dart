import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recycle/constants.dart';

import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

import 'package:image/image.dart' as Img;

typedef Model = tfl.Interpreter;

const String modelPath = 'assets/model.tflite';

class ClassificationState extends ChangeNotifier {
  Model? model;
  Image? _currentImage;

  Image? get currentImage => _currentImage;

  set currentImage(Image? value) {
    _currentImage = value;
  }

  Future<void> loadModel() async {
    model = await tfl.Interpreter.fromAsset(modelPath);
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
