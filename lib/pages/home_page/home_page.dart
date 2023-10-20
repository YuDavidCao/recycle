import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:recycle/constants.dart';
import 'package:recycle/controller/classification_state.dart';

import 'package:image/image.dart' as Img;
import 'package:recycle/controller/daily_progress_state.dart';
import 'package:recycle/ultilities.dart';

typedef PreProcessedImage = List<List<List<List<num>>>>;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentLabel = "None";

  Future<String> selectPicture(ImageSource imageSource) async {
    XFile? imageXfile = await ImagePicker().pickImage(source: imageSource);
    try {
      if (imageXfile != null) {
        File imgFile = File(imageXfile.path);
        if (context.mounted) {
          Provider.of<ClassificationState>(context, listen: false).filePath =
              imgFile;
          Provider.of<ClassificationState>(context, listen: false)
              .currentImage = Image.file(imgFile);
        }
        final Img.Image? image =
            Img.decodeImage(Uint8List.fromList(imgFile.readAsBytesSync()));
        if (context.mounted) {
          return await Provider.of<ClassificationState>(context, listen: false)
              .predict(Img.copyResize(image!,
                  width: classificationWidth, height: classificiationHeight));
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something wrong happened')));
      }
      return "Selection Failed";
    }
    return "Selection Failed";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: globalEdgePadding,
          ),
          Padding(
            padding: globalMiddleWidgetPadding,
            child: Consumer<DailyProgressState>(
              builder: (context, DailyProgressState dailyProgressState, child) {
                return Column(
                  children: [
                    Text("${dailyProgressState.currentTotalCount} / 30"),
                    LinearPercentIndicator(
                      barRadius: const Radius.circular(10),
                      padding: const EdgeInsets.all(0),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.amber,
                      animation: true,
                      lineHeight: globalEdgePadding,
                      // percent: 0.2,
                      percent: dailyProgressState.currentPercentage,
                    ),
                  ],
                );
              },
            ),
          ),
          Flexible(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(globalEdgePadding),
              crossAxisSpacing: globalMarginPadding,
              mainAxisSpacing: globalMarginPadding,
              crossAxisCount: 2,
              children: [
                ...classificationLabels.map(
                  (String type) => Container(
                    padding: const EdgeInsets.all(globalMarginPadding),
                    color: thirtyUIColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Text(type),
                            ),
                            Positioned(
                              right: -16,
                              top: -16,
                              child: IconButton(
                                  onPressed: () {
                                    displayTypeInfo(context, type);
                                  },
                                  icon: const Icon(Icons.arrow_right)),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: globalEdgePadding,
                                  ),
                                  AspectRatio(
                                    aspectRatio: 1.2,
                                    child: Image.asset(
                                      "assets/images/$type.png",
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Wrap(
        children: [
          FloatingActionButton(
            onPressed: () async {
              // Utilities.testPrint();
              String label = await selectPicture(ImageSource.camera);
              if (label != "Selection Failed" && context.mounted) {
                Navigator.of(context)
                    .pushNamed("/ClassificationLabelPage", arguments: [label]);
              }
            },
            backgroundColor: tenUIColor,
            heroTag: null,
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(
            width: globalEdgePadding,
          ),
          FloatingActionButton(
            //TODO
            onPressed: () async {
              // Provider.of<DailyProgressState>(context, listen: false)
              //     .incrementDailyProgress("metal");
              String label = await selectPicture(ImageSource.gallery);
              if (label != "Selection Failed" && context.mounted) {
                Navigator.of(context)
                    .pushNamed("/ClassificationLabelPage", arguments: [label]);
              }
            },
            backgroundColor: tenUIColor,
            heroTag: null,
            child: const Icon(Icons.upload),
          )
        ],
      ),
    );
  }
}

// class DailyProgressIndicator extends StatefulWidget {
//   const DailyProgressIndicator({super.key});

//   @override
//   State<DailyProgressIndicator> createState() => _DailyProgressIndicatorState();
// }

// class _DailyProgressIndicatorState extends State<DailyProgressIndicator> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<DailyProgressState>(
//       builder: (context, DailyProgressState dailyProgressState, child) {
//         return LinearPercentIndicator(
//           width: MediaQuery.of(context).size.width - globalEdgePadding * 2,
//           animation: true,
//           lineHeight: globalEdgePadding,
//           animationDuration: 2500,
//           percent: dailyProgressState.currentPercentage,
//           center: Text(
//               "${(dailyProgressState.currentPercentage * 100).toStringAsFixed(1)}%"),
//           progressColor: Colors.green,
//         );
//       },
//     );
//   }
// }

void displayTypeInfo(BuildContext context, String type) async {
  await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) {
        return const HelperSheet();
      });
}

class HelperSheet extends StatefulWidget {
  const HelperSheet({super.key});

  @override
  State<HelperSheet> createState() => _HelperSheetState();
}

class _HelperSheetState extends State<HelperSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        minChildSize: 0.2,
        maxChildSize: 0.9,
        builder: ((context, scrollController) {
          return Column(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [],
              ),
            ],
          );
        }));
  }
}
