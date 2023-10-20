import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycle/constants.dart';
import 'package:recycle/controller/classification_state.dart';
import 'package:recycle/firebase/firebase_firestore_service.dart';
import 'package:recycle/firebase/firebase_storage_service.dart';

class ClassificationLabelPage extends StatefulWidget {
  final String label;
  const ClassificationLabelPage({super.key, required this.label});

  @override
  State<ClassificationLabelPage> createState() =>
      _ClassificationLabelPageState();
}

class _ClassificationLabelPageState extends State<ClassificationLabelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Provider.of<ClassificationState>(context, listen: false)
              .currentImage!,
          Padding(
            padding: const EdgeInsets.all(globalEdgePadding),
            child: Text(
              widget.label,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                reportPredictionError(context, widget.label);
              },
              child: const Text("Prediction Wrong?"))
        ],
      ),
    );
  }
}

void reportPredictionError(BuildContext context, String currentLabel) async {
  await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) {
        return PredictionErrorSheet(currentLabel: currentLabel);
      });
}

class PredictionErrorSheet extends StatefulWidget {
  final String currentLabel;
  const PredictionErrorSheet({super.key, required this.currentLabel});

  @override
  State<PredictionErrorSheet> createState() => _PredictionErrorSheetState();
}

class _PredictionErrorSheetState extends State<PredictionErrorSheet> {
  int selectedValue = 0;

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
              const SizedBox(
                height: globalEdgePadding,
              ),
              const Text(
                "What should the correct classification be?",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: globalEdgePadding,
              ),
              ...classificationLabels.asMap().entries.map((mapEntry) {
                return ListTile(
                  title: Text(mapEntry.value),
                  leading: Radio(
                    value: mapEntry.key,
                    groupValue: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value!;
                      });
                    },
                  ),
                );
              }).toList(),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height / 3,
              //   // constraints: BoxConstraints.tight(Size(double.infinity,500)),
              //   child: ListView.builder(
              //     itemCount: classificationLabels.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return ListTile(
              //         title: Text(classificationLabels[index]),
              //         leading: Radio(
              //           value: index,
              //           groupValue: selectedValue,
              //           onChanged: (value) {
              //             setState(() {
              //               selectedValue = value!;
              //             });
              //           },
              //         ),
              //       );
              //     },
              //   ),
              // ),
              ElevatedButton(
                  onPressed: () async {
                    DocumentReference? documentReference =
                        await FirebaseFirestoreService
                            .submitErrorWithoutPicture(widget.currentLabel,
                                classificationLabels[selectedValue], context);
                    print(1);
                    if (documentReference != null && context.mounted) {
                      FirebaseStorageService.submitErrorPicture(
                          Provider.of<ClassificationState>(context,
                                  listen: false)
                              .filePath!,
                          widget.currentLabel,
                          classificationLabels[selectedValue],
                          documentReference.id);
                    }
                  },
                  child: const Text("Submit"))
            ],
          );
        }));
  }
}
