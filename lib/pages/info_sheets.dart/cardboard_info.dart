import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recycle/constants.dart';

class CardBoardInfo extends StatefulWidget {
  const CardBoardInfo({super.key});

  @override
  State<CardBoardInfo> createState() => _CardBoardInfoState();
}

class _CardBoardInfoState extends State<CardBoardInfo> {
  String introduction =
      "Cardboard recycling is a simple yet impactful way to contribute to environmental sustainability. By recycling cardboard, you can help save trees, reduce landfill waste, and minimize the environmental footprint of packaging materials.";

  String faqs = """
•  Can I recycle pizza boxes? Yes, as long as they are not heavily soiled with grease or food.

•  Do I need to remove tape from cardboard before recycling? It's a good practice to remove tape, as it makes the recycling process more efficient.

•  What about cardboard with labels and printing? Cardboard with labels and printing is typically recyclable.
""";

  String recyclingTips = """
•  Flatten cardboard boxes to save space in your recycling bin. 

•  Remove any non-cardboard materials, including plastic packaging and tape.

•  Be mindful not to contaminate cardboard with food waste or liquids.
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
                  "Cardboard recycling",
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
                  "FAQ:",
                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: globalMiddleWidgetPadding,
                child: Text(faqs, style: GoogleFonts.roboto()),
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
