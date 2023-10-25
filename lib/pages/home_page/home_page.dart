import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:recycle/constants.dart';
import 'package:recycle/controller/classification_state.dart';

import 'package:image/image.dart' as Img;
import 'package:recycle/controller/daily_progress_state.dart';
import 'package:recycle/pages/info_sheets.dart/cardboard_info.dart';
import 'package:recycle/pages/info_sheets.dart/glass_info.dart';
import 'package:recycle/pages/info_sheets.dart/metal_info.dart';
import 'package:recycle/pages/info_sheets.dart/paper_info.dart';
import 'package:recycle/pages/info_sheets.dart/plastic_info.dart';
import 'package:recycle/pages/info_sheets.dart/trash_info.dart';
import 'package:recycle/ultilities.dart';
import 'package:recycle/widgets/global_drawer.dart';
import 'package:recycle/widgets/global_logger.dart';

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
      drawer: const GlobalDrawer(currentPage: "HomePage"),
      body: Column(
        children: [
          const SizedBox(
            height: globalEdgePadding,
          ),
          Padding(
            padding: globalMiddleWidgetPadding,
            child: Consumer<DailyProgressState>(
              builder: (context, DailyProgressState dailyProgressState, child) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        //TODO
                        // Align(
                        //   alignment: Alignment.topCenter,
                        //   child: ConfettiWidget(
                        //     maximumSize: const Size(30, 30),
                        //     shouldLoop: false,
                        //     confettiController: ConfettiController(
                        //         duration: const Duration(seconds: 10))
                        //       ..play(),
                        //     blastDirectionality: BlastDirectionality.explosive,
                        //     maxBlastForce: 14,
                        //     minBlastForce: 5,
                        //     emissionFrequency: 0.2,
                        //     gravity: 1,
                        //   ),
                        // ),
                        Text(
                            "Daily Goal:  ${dailyProgressState.currentTotalCount} / $dailyClassificationThreshold"),
                        LinearPercentIndicator(
                          barRadius: const Radius.circular(10),
                          padding: const EdgeInsets.all(0),
                          backgroundColor:
                              const Color.fromARGB(255, 213, 213, 213),
                          progressColor: Colors.amber,
                          animation: true,
                          lineHeight: globalEdgePadding,
                          // percent: 0.2,
                          percent: dailyProgressState.currentPercentage,
                        ),
                      ],
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
              crossAxisSpacing: globalEdgePadding,
              mainAxisSpacing: globalEdgePadding,
              crossAxisCount: 2,
              children: [
                ...classificationLabels.map(
                  (String type) => Container(
                    padding: const EdgeInsets.all(globalMarginPadding),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: thirtyUIColor,
                    ),
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
                Provider.of<DailyProgressState>(context, listen: false)
                    .incrementDailyProgress(label);
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
                Provider.of<DailyProgressState>(context, listen: false)
                    .incrementDailyProgress(label);
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

void displayTypeInfo(BuildContext context, String type) async {
  await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) {
        switch (type) {
          case 'cardboard':
            return const CardBoardInfo();
          case 'glass':
            return const GlassInfo();
          case 'metal':
            return const MetalInfo();
          case 'paper':
            return const PaperInfo();
          case 'plastic':
            return const PlasticInfo();
          case 'trash':
            return const TrashInfo();
          default:
            return const Placeholder();
        }
      });
}
