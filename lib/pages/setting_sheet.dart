import 'package:flutter/material.dart';
import 'package:recycle/constants.dart';
import 'package:recycle/main.dart';
import 'package:recycle/pages/helper_sheet.dart';

class SettingSheet extends StatelessWidget {
  const SettingSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.2,
        maxChildSize: 0.9,
        builder: ((context, scrollController) {
          return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 60,
                    height: 7,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const DeleteAllDataSetting(),
                  const TurnOffImageUploadingSetting(),
                  const DisplayHelperSheetWidget(),
                ],
              ));
        }));
  }
}

class DeleteAllDataSetting extends StatelessWidget {
  const DeleteAllDataSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: globalMiddleWidgetPadding,
      width: double.infinity,
      height: 48,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const SizedBox(
                  height: 150,
                  child: Column(
                    children: [
                      Text("Are you sure you want to delete all data?")
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      await dailyProgressBox.clear();
                      await totalStatisticBox.clear();
                      for (int i = 0; i < classificationLabels.length; i++) {
                        totalStatisticBox.put(
                            "${classificationLabels[i]}Count", 0);
                      }
                      totalStatisticBox.put("totalCount", 0);
                    },
                  ),
                  TextButton(
                    child: const Text(
                      "No",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "Delete all data",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

class TurnOffImageUploadingSetting extends StatelessWidget {
  const TurnOffImageUploadingSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: globalMiddleWidgetPadding,
      width: double.infinity,
      height: 48,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const SizedBox(
                  height: 150,
                  child: Column(
                    children: [
                      Text(
                          "Are you sure you want to stop uploading misclassified images?")
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      "Yes",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      settingBox.put("image tracking agreement", false);
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text(
                      "No",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "Turn off image uploading",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

class DisplayHelperSheetWidget extends StatelessWidget {
  const DisplayHelperSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: globalMiddleWidgetPadding,
      width: double.infinity,
      height: 48,
      child: GestureDetector(
        onTap: () async {
          await displayHelpers(context);
          if (context.mounted) {
            Navigator.pop(context);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "Help",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
