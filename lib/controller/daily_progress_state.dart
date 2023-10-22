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

  void calcDailyProgress() async {
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

  void incrementDailyProgress(String type) {
    final String keyTerm = DateTime.now().getDateOnly().toString();
    DailyProgressModel dailyProgressModel = dailyProgressBox.get(keyTerm);
    switch (type) {
      case "cardboard":
        dailyProgressModel.cardboardCount++;
        break;
      case "glass":
        dailyProgressModel.glassCount++;
        break;
      case "metal":
        dailyProgressModel.metalCount++;
        break;
      case "paper":
        dailyProgressModel.paperCount++;
        break;
      case "plastic":
        dailyProgressModel.plasticCount++;
        break;
      case "trash":
        dailyProgressModel.trash++;
        break;
      default:
    }
    dailyProgressModel.totalCount++;
    dailyProgressBox.put(keyTerm, dailyProgressModel);
    totalStatisticBox.put(
        "${type}Count", totalStatisticBox.get("${type}Count") + 1);
    totalStatisticBox.put(
        "totalCount", totalStatisticBox.get("totalCount") + 1);
    calcDailyProgress();
  }

  static List<DateTime> getPreviousWeekdays({DateTime? inputDateTime}) {
    inputDateTime = inputDateTime ?? DateTime.now();
    List<DateTime> previousWeekdays = [];
    bool start = false;
    int i = -7;
    while (previousWeekdays.length != 7) {
      DateTime wd = DateTime.now().getDateOnly().add(Duration(days: i));
      if (wd.weekday == 1) {
        start = true;
      }
      if (start) {
        previousWeekdays.add(wd.getDateOnly());
      }
      i++;
    }
    return previousWeekdays;
  }

  List<double> getBarChartData() {
    List<DateTime> previousWeekdays = getPreviousWeekdays();
    List<double> barChartStatistics = [];
    for (int i = 0; i < previousWeekdays.length; i++) {
      if (dailyProgressBox.containsKey(previousWeekdays[i].toString())) {
        barChartStatistics.add(dailyProgressBox
            .get(previousWeekdays[i].toString())
            .totalCount
            .toDouble());
      } else {
        barChartStatistics.add(0);
      }
    }
    return barChartStatistics;
  }
}
