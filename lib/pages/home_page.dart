import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recycle/constants.dart';
import 'package:recycle/controller/classification_state.dart';

import 'package:image/image.dart' as Img;



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
          // FloatingActionButton(
          //   onPressed: () {
          //     Provider.of<ClassificationState>(context, listen: false)
          //         .generateRandomList(1, 244, 244, 3);
          //     // .predict();
          //   },
          //   backgroundColor: Colors.amber,
          //   child: const Icon(Icons.batch_prediction),
          // ),
          FloatingActionButton(
            onPressed: () async {
              String tempLabel = await selectPicture(ImageSource.camera);
              setState(() {
                currentLabel = tempLabel;
              });
            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.camera),
          )
        ],
      ),
    );
  }
}
