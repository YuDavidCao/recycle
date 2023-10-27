import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recycle/constants.dart';

class PlasticInfo extends StatefulWidget {
  const PlasticInfo({super.key});

  @override
  State<PlasticInfo> createState() => _PlasticInfoState();
}

class _PlasticInfoState extends State<PlasticInfo> {
  String introduction =
      "Recycling plastic is an essential step in reducing plastic pollution, conserving natural resources, and protecting our environment. Plastic recycling helps divert plastic waste from landfills and oceans, minimizing the environmental impact of this versatile material.";
  String recyclablePapers = """
•  Plastic Cups & Containers

•  Plastic Bottles & Lids

•  Plastic Bags

•  Bulky Plastic Items
""";

  String recyclingTips = """
•  Check the recycling code (a number inside the recycling symbol) to identify the plastic type and check your local recycling guidelines for which plastics are accepted.

•  Rinse or clean plastic containers before recycling to remove residues.

•  Be cautious about recycling plastic items that may contain harmful chemicals or are not commonly accepted, like styrofoam.
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
                  "Plastic recycling",
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
                  "Typical plastic recyclables:",
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
