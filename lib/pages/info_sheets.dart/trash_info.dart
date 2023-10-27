import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recycle/constants.dart';

class TrashInfo extends StatefulWidget {
  const TrashInfo({super.key});

  @override
  State<TrashInfo> createState() => _TrashInfoState();
}

class _TrashInfoState extends State<TrashInfo> {
  String introduction =
      "Proper disposal of non-recyclable waste, commonly referred to as \"trash,\" is essential for maintaining a clean and healthy environment. By following proper disposal practices, we can keep our communities clean and protect our natural surroundings.";
  String recyclablePapers =
      "Non-recyclable waste includes items that cannot be recycled or composted, such as food scraps, sanitary products, certain plastics, broken glass, and other materials that don't fit into recycling or composting categories.";

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        minChildSize: 0.2,
        maxChildSize: 0.9,
        builder: ((context, scrollController) {
          return Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: 60,
                  height: 7,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: globalEdgePadding,
              ),
              Center(
                child: Text(
                  "Trash",
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const Divider(
                color: Colors.black,
                indent: globalEdgePadding,
                endIndent: globalEdgePadding,
              ),
              Padding(
                padding: globalMiddleWidgetPadding,
                child: Text(
                  introduction,
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(height: 1.4)),
                ),
              ),
              const Divider(
                color: Colors.black,
                indent: globalEdgePadding,
                endIndent: globalEdgePadding,
              ),
              Padding(
                padding: globalMiddleWidgetPadding,
                child: Text(
                  "What Qualifies as Trash:",
                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: globalMiddleWidgetPadding,
                child: Text(recyclablePapers,
                    style: GoogleFonts.roboto(height: 1.4)),
              ),
              const Divider(
                color: Colors.black,
                indent: globalEdgePadding,
                endIndent: globalEdgePadding,
              ),
              Padding(
                padding: globalMiddleWidgetPadding,
                child: Text(
                  "Trash Disposal Practices:",
                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(
                      globalEdgePadding, 0, globalEdgePadding, 0),
                  child: RichText(
                    text: TextSpan(
                      text: '',
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              color: Colors.black, height: 1.4)),
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'Use Trash Bins: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                'Always use designated trash bins for waste disposal at your home, workplace, or public spaces.'),
                      ],
                    ),
                  )),
              const SizedBox(
                height: globalMarginPadding,
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(
                      globalEdgePadding, 0, globalEdgePadding, 0),
                  child: RichText(
                    text: TextSpan(
                      text: '',
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              color: Colors.black, height: 1.4)),
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'Secure Trash Bags: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                'When disposing of trash, place it in sturdy trash bags to prevent littering and contain odors.'),
                      ],
                    ),
                  )),
              // const SizedBox(
              //   height: globalMarginPadding,
              // ),
              // Padding(
              //     padding: const EdgeInsets.fromLTRB(
              //         globalEdgePadding, 0, globalEdgePadding, 0),
              //     child: RichText(
              //       text: TextSpan(
              //         text: '',
              //         style: GoogleFonts.roboto(
              //             textStyle: const TextStyle(
              //                 color: Colors.black, height: 1.4)),
              //         children: const <TextSpan>[
              //           TextSpan(
              //               text: 'Proper Sealing: ',
              //               style: TextStyle(fontWeight: FontWeight.bold)),
              //           TextSpan(
              //               text:
              //                   'Seal trash bags tightly to minimize the escape of unpleasant odors and pests.'),
              //         ],
              //       ),
              //     )),
              const SizedBox(
                height: globalMarginPadding,
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(
                      globalEdgePadding, 0, globalEdgePadding, 0),
                  child: RichText(
                    text: TextSpan(
                      text: '',
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              color: Colors.black, height: 1.4)),
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'Follow Local Guidelines: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                'Adhere to your local waste disposal guidelines and schedules for curbside pickup or drop-off locations.'),
                      ],
                    ),
                  )),
              const SizedBox(
                height: globalMarginPadding,
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(
                      globalEdgePadding, 0, globalEdgePadding, 0),
                  child: RichText(
                    text: TextSpan(
                      text: '',
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              color: Colors.black, height: 1.4)),
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'Hazardous Materials:: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                'Properly dispose of hazardous materials, such as batteries, chemicals, or electronic waste, by following local hazardous waste disposal procedures.'),
                      ],
                    ),
                  )),
              const SizedBox(
                height: globalEdgePadding * 3,
              ),
            ],
          );
        }));
  }
}
