import 'package:flutter/material.dart';
import 'package:recycle/constants.dart';
import 'package:recycle/custom_extensions.dart';
import 'package:recycle/main.dart';
import 'package:recycle/model/daily_progress_model.dart';

class DailyProgressState extends ChangeNotifier {
  double _currentPercentage = 0;

  double get currentPercentage => _currentPercentage;

  set currentPercentage(double value) {
    _currentPercentage = value;
  }

  int _currentTotalCount = 0;

  int get currentTotalCount => _currentTotalCount;

  set currentTotalCount(int value) {
    _currentTotalCount = value;
  }

  void initFunction() async {
    final String keyTerm = DateTime.now().getDateOnly().toString();
    if (!dailyProgressBox.containsKey(keyTerm)) {
      await dailyProgressBox.put(
          keyTerm,
          DailyProgressModel(
              progressDateTime: DateTime.now().getDateOnly(),
              totalCount: 0,
              cardboardCount: 0,
              glassCount: 0,
              metalCount: 0,
              paperCount: 0,
              plasticCount: 0,
              trash: 0));
    }
    currentTotalCount = dailyProgressBox.get(keyTerm).totalCount;
    currentPercentage =
        currentTotalCount.toDouble() / dailyClassificationThreshold.toDouble();
    notifyListeners();
  }
}
