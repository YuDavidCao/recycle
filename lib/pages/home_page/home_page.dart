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

typedef PreProcessedImage = List<List<List<List<num>>>>;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentLabel = "None";

  Future<String> selectPicture(ImageSource imageSource) async {
    final Img.Image? image = Img.decodeImage(Uint8List.fromList(
        File((await ImagePicker().pickImage(source: imageSource))!.path)
            .readAsBytesSync()));
    if (image != null && context.mounted) {
      return await Provider.of<ClassificationState>(context, listen: false)
          .predict(Img.copyResize(image,
              width: classificationWidth, height: classificiationHeight));
    }
    return "Selection Failed";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const DailyProgressIndicator(),
          Center(
            child: Text(
              currentLabel,
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      floatingActionButton: Wrap(
        children: [
          FloatingActionButton(
            onPressed: () async {
              String tempLabel = await selectPicture(ImageSource.camera);
              setState(() {
                currentLabel = tempLabel;
              });
            },
            backgroundColor: tenUIColor,
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(
            width: globalEdgePadding,
          ),
          FloatingActionButton(
            onPressed: () async {
              String tempLabel = await selectPicture(ImageSource.camera);
              setState(() {
                currentLabel = tempLabel;
              });
            },
            backgroundColor: tenUIColor,
            child: const Icon(Icons.upload),
          )
        ],
      ),
    );
  }
}

class DailyProgressIndicator extends StatefulWidget {
  const DailyProgressIndicator({super.key});

  @override
  State<DailyProgressIndicator> createState() => _DailyProgressIndicatorState();
}

class _DailyProgressIndicatorState extends State<DailyProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DailyProgressState>(
      builder: (context, DailyProgressState dailyProgressState, child) {
        return LinearPercentIndicator(
          width: MediaQuery.of(context).size.width - globalEdgePadding * 2,
          animation: true,
          lineHeight: globalEdgePadding,
          animationDuration: 2500,
          percent: dailyProgressState.currentPercentage,
          center: Text(
              "${(dailyProgressState.currentPercentage * 100).toStringAsFixed(1)}%"),
          progressColor: Colors.green,
        );
      },
    );
  }
}
