import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recycle/constants.dart';

class MetalInfo extends StatefulWidget {
  const MetalInfo({super.key});

  @override
  State<MetalInfo> createState() => _MetalInfoState();
}

class _MetalInfoState extends State<MetalInfo> {
  String introduction =
      "Recycling metals is an eco-friendly and sustainable choice that helps conserve natural resources, reduce energy consumption, and minimize waste. Metal recycling plays a crucial role in environmental protection and resource conservation.";
  String recyclablePapers = """
•  Scrap Metal

•  Tin Cans & Aluminum Cans

•  Aluminum Foil

•  Metal bottles/Containers
""";

  String recyclingTips = """
•  Rinse or clean metal items before recycling to remove residues.

•  Separate ferrous and non-ferrous metals when recycling, as they have different recycling processes.

•  Ensure that metal items are free from non-metal components, like plastic or rubber.
""";

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
                  "Metal recycling",
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
                  "Typical metal recyclables:",
                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: globalMiddleWidgetPadding,
                child: Text(recyclablePapers, style: GoogleFonts.roboto()),
              ),
              const Divider(
                color: Colors.black,
                indent: globalEdgePadding,
                endIndent: globalEdgePadding,
              ),
              Padding(
                padding: globalMiddleWidgetPadding,
                child: Text(
                  "Recycling tips:",
                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: globalMiddleWidgetPadding,
                child: Text(recyclingTips, style: GoogleFonts.roboto()),
              ),
              const SizedBox(
                height: globalEdgePadding * 3,
              ),
            ],
          );
        }));
  }
}
