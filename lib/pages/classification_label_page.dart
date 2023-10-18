import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycle/constants.dart';
import 'package:recycle/controller/classification_state.dart';

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
                reportPredictionError(context);
              },
              child: const Text("Prediction Wrong?"))
        ],
      ),
    );
  }
}

void reportPredictionError(BuildContext context) async {
  await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) {
        return const Scaffold();
      });
}

class PredictionErrorSheet extends StatefulWidget {
  const PredictionErrorSheet({super.key});

  @override
  State<PredictionErrorSheet> createState() => _PredictionErrorSheetState();
}

class _PredictionErrorSheetState extends State<PredictionErrorSheet> {
  int selectedValue = 0;

  final List<String> options = [
    "Option 1",
    "Option 2",
    "Option 3",
    "Option 4",
    "Option 5",
    "Option 6",
    "Option 7",
  ];

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
              ListView.builder(
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(options[index]),
                    leading: Radio(
                      value: index,
                      groupValue: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      },
                    ),
                  );
                },
              )
            ],
          );
        }));
  }
}
