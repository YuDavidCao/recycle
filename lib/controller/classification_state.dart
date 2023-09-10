import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recycle/pages/home_page.dart';

import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

import 'dart:math';

typedef Model = tfl.Interpreter;

String modelPath = 'assets/model.tflite';

final List<String> labels = [
  'cardboard',
  'glass',
  'metal',
  'paper',
  'plastic',
  'trash'
];

class ClassificationState extends ChangeNotifier {
  Model? model;

  tfl.Tensor? inputTensor;
  tfl.Tensor? outputTensor;

  Future<void> loadModel() async {
    model = await tfl.Interpreter.fromAsset(modelPath);
    inputTensor = model?.getInputTensors().first;
    inputTensor = model?.getOutputTensors().first;
    print(inputTensor?.shape);
    print(outputTensor?.shape);
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
    print(randomList.shape);
    return randomList;
  }

  void testpredict() {}

  Future<String> predict(PreProcessedImage image) async {
    if (model == null) {
      await loadModel();
    }
    List<dynamic> output = [
      [0, 0, 0, 0, 0, 0]
    ];
    model?.run(image, output);
    return decodeLabel(output);
  }

  String decodeLabel(List<dynamic> rawOutput) {
    int maxIndex = 0;
    double maxValue = rawOutput[0][0];
    for (int i = 1; i < 6; i++) {
      if (rawOutput[0][i] > maxValue) {
        maxValue = rawOutput[0][i];
        maxIndex = i;
      }
    }
    return labels[maxIndex];
  }
}
