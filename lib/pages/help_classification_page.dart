import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycle/constants.dart';
import 'package:recycle/controller/classification_helper_state.dart';
import 'package:recycle/firebase/firebase_firestore_service.dart';
import 'package:recycle/firebase/firebase_storage_service.dart';
import 'package:recycle/widgets/global_drawer.dart';

class HelpClassificationPage extends StatefulWidget {
  const HelpClassificationPage({super.key});

  @override
  State<HelpClassificationPage> createState() => _HelpClassificationPageState();
}

class _HelpClassificationPageState extends State<HelpClassificationPage> {
  @override
  void initState() {
    Provider.of<ClassificationHelperState>(context, listen: false)
        .nextImage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const GlobalDrawer(
        currentPage: "HelpClassificationPage",
      ),
      body: Consumer<ClassificationHelperState>(
        builder: (context, ClassificationHelperState classificationHelperState,
            child) {
          if (classificationHelperState.documentSnapshot == null) {
            return const Center(child: Text("Unable to fetch image"));
          } else {
            if (classificationHelperState.noMoreImages) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text("No more images"),
                  )
                ],
              );
            } else {
              return ListView(
                children: [
                  FutureBuilder<Widget>(
                    future: FirebaseStorageService.getImageByDocumentId(
                        classificationHelperState.documentSnapshot!.id,
                        classificationHelperState
                            .documentSnapshot!["errorLabel"]),
                    builder:
                        (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!;
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        );
                      }
                    },
                  ),
                  const LabelingWidget(),
                  const SizedBox(
                    height: globalEdgePadding * 3,
                  )
                ],
              );
            }
          }
        },
      ),
    );
  }
}

class LabelingWidget extends StatefulWidget {
  const LabelingWidget({super.key});

  @override
  State<LabelingWidget> createState() => LabelingWidgetState();
}

class LabelingWidgetState extends State<LabelingWidget> {
  int selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        ElevatedButton(
            onPressed: () async {
              await FirebaseFirestoreService.submitErroredPictureLabel(
                  Provider.of<ClassificationHelperState>(context, listen: false)
                      .documentSnapshot!
                      .id,
                  context,
                  classificationLabels[selectedValue]);
              if (context.mounted) {
                Provider.of<ClassificationHelperState>(context, listen: false)
                    .nextImage(context);
              }
            },
            child: const Text("Submit"))
      ],
    );
  }
}
