import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recycle/constants.dart';

class PaperInfo extends StatefulWidget {
  const PaperInfo({super.key});

  @override
  State<PaperInfo> createState() => _PaperInfoState();
}

class _PaperInfoState extends State<PaperInfo> {
  String introduction =
      "Recycling paper is an essential step in conserving our environment and reducing our ecological footprint. By recycling paper, we can help save trees, reduce greenhouse gas emissions, and minimize waste.";
  String recyclablePapers = """
•  Cups & Containers

•  Milk, Juice, & Soup Cartons

•  Newspapers/Magazines

•  Books/Phone Books

•  Junk Mail & Office Paper""";

  String recyclingTips = """
•  Remove non-paper materials, such as plastic windows on envelopes, before recycling.

•  Recycle shredded paper in paper bags to prevent it from becoming litter.
""";

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        minChildSize: 0.2,
        maxChildSize: 0.9,
        builder: ((context, scrollController) {
          return ListView(
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
                  "Typical paper recyclables:",
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
                  "What to recycle:",
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
