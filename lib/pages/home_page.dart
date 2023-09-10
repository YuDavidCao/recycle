import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:recycle/controller/classification_state.dart';

import 'package:flutter/services.dart' show rootBundle;

import 'package:image/image.dart' as Img;

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');
  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  return file;
}

typedef PreProcessedImage = List<List<List<List<num>>>>;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentLabel = "None";

  Future<String> selectPicture(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    File imageFile = File((await picker.pickImage(source: imageSource))!.path);
    // File imageFile = await getImageFileFromAssets('glass17.jpg');
    List<int> imageBytes = imageFile.readAsBytesSync();
    final Img.Image? image = Img.decodeImage(Uint8List.fromList(imageBytes));
    if (image != null) {
      final Img.Image resizedImage =
          Img.copyResize(image, width: 224, height: 224);
      if (context.mounted) {
        return await Provider.of<ClassificationState>(context, listen: false)
            .predict(createShapedList(resizedImage));
      }
    }
    return "Selection Failed";
  }

  PreProcessedImage createShapedList(Img.Image image) {
    const int width = 224;
    const int height = 224;
    final List<List<List<num>>> shapedList = List.generate(
      height,
      (y) => List.generate(
        width,
        (x) {
          final pixel = image.getPixel(x, y);
          return [pixel.r, pixel.g, pixel.b];
        },
      ),
    );
    return [shapedList];
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
