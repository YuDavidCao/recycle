import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycle/controller/classification_helper_statr.dart';
import 'package:recycle/firebase/firebase_storage_service.dart';

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
      body: Consumer<ClassificationHelperState>(
        builder: (context, ClassificationHelperState classificationHelperState,
            child) {
          if (classificationHelperState.documentSnapshot == null) {
            return const Center(child: Text("Unable to fetch image"));
          } else {
            return Column(
              children: [
                FutureBuilder<Widget>(
                  future: FirebaseStorageService.getImageByDocumentId(
                      classificationHelperState.documentSnapshot!.id,
                      classificationHelperState.documentSnapshot!["errorLabel"]),
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
              ],
            );
          }
        },
      ),
    );
  }
}
