import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:recycle/constants.dart';
import 'package:recycle/controller/daily_progress_state.dart';
import 'package:recycle/main.dart';
import 'package:recycle/ultilities.dart';
import 'package:recycle/widgets/global_drawer.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  Widget generateDataComponent(String text, String statistic) {
    return Padding(
      padding: globalMiddleWidgetPadding,
      child: Container(
        padding: globalMiddleWidgetPadding,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[350]!),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total $text recycled",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              statistic,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const GlobalDrawer(currentPage: "StatisticPage"),
      body: Column(
        children: [
          const SizedBox(
            height: globalEdgePadding,
          ),
          // Consumer<DailyProgressState>(
          //   builder: (context, DailyProgressState dailyProgressState, child) {
          //     return CircularPercentIndicator(
          //       radius: 100,
          //       lineWidth: 13.0,
          //       animation: true,
          //       percent: dailyProgressState.currentPercentage,
          //       center: Text(
          //         "${dailyProgressState.currentTotalCount} / 30",
          //         style: const TextStyle(
          //             fontWeight: FontWeight.bold, fontSize: 20.0),
          //       ),
          //       footer: const Text(
          //         "Daily Goal",
          //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          //       ),
          //       circularStrokeCap: CircularStrokeCap.round,
          //       progressColor: tenUIColor,
          //     );
          //   },
          // ),
          ...classificationLabels.map((String labelText) {
            return generateDataComponent(labelText,
                totalStatisticBox.get("${labelText}Count").toString());
          }).toList()
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        // Utilities.printStatistics();
      }, child: const Icon(
        Icons.share
      ),),
    );
  }
}
