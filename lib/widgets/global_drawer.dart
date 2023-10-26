import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:recycle/constants.dart';
import 'package:recycle/controller/daily_progress_state.dart';
import 'package:recycle/pages/helper_sheet.dart';

class GlobalDrawer extends StatefulWidget {
  final String currentPage;
  const GlobalDrawer({super.key, required this.currentPage});

  @override
  State<GlobalDrawer> createState() => _GlobalDrawerState();
}

class _GlobalDrawerState extends State<GlobalDrawer> {
  GestureDetector generateDrawerContainer(
      Function() funcion, String text, bool ifCurrent, IconData iconData) {
    return GestureDetector(
        onTap: funcion,
        child: Container(
          decoration: (ifCurrent)
              ? BoxDecoration(
                  color: tenUIColor,
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(4)))
              : null,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: globalEdgePadding,
              ),
              Icon(
                iconData,
                color: Colors.black,
                size: 30.0,
              ),
              const SizedBox(
                width: globalEdgePadding,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 17,
                ),
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: globalEdgePadding,
          ),
          Consumer<DailyProgressState>(
            builder: (context, DailyProgressState dailyProgressState, child) {
              return CircularPercentIndicator(
                radius: 100,
                lineWidth: 13.0,
                animation: true,
                percent: dailyProgressState.currentPercentage,
                center: Text(
                  "${dailyProgressState.currentTotalCount} / $dailyClassificationThreshold",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: const Text(
                  "Daily Goal",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: tenUIColor,
              );
            },
          ),
          generateDrawerContainer(() {
            Navigator.of(context).pushReplacementNamed(
              '/HomePage',
            );
          }, "Home", widget.currentPage == "HomePage", Icons.home),
          generateDrawerContainer(() {
            Navigator.of(context).pushReplacementNamed(
              '/StatisticPage',
            );
          }, "Statistic", widget.currentPage == "StatisticPage",
              Icons.analytics_outlined),
          generateDrawerContainer(() {
            Navigator.of(context).pushReplacementNamed(
              '/HelpClassificationPage',
            );
          },
              "Help with classification",
              widget.currentPage == "HelpClassificationPage",
              Icons.remove_red_eye),
          generateDrawerContainer(() {
            displayHelpers(context);
          }, "Help", widget.currentPage == "_", Icons.help),
          const SizedBox(
            height: globalEdgePadding,
          ),
        ],
      ),
    );
  }
}
