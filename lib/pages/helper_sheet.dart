import 'package:flutter/material.dart';
import 'package:recycle/constants.dart';

void displayHelpers(BuildContext context) async {
  await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) {
        return const HelperSheet();
      });
}

class HelperSheet extends StatefulWidget {
  const HelperSheet({super.key});

  @override
  State<HelperSheet> createState() => _HelperSheetState();
}

class _HelperSheetState extends State<HelperSheet> {
  final PageController controller = PageController();
  int _currentPage = 0;
  List<Image> images = [
    Image.asset("assets/guide/guide1.png", fit: BoxFit.scaleDown),
    // Image.asset("assets/guide/guide 2.png", fit: BoxFit.scaleDown),
    // Image.asset("assets/guide/guide 3.png", fit: BoxFit.scaleDown),
    // Image.asset("assets/guide/guide 4.png", fit: BoxFit.scaleDown),
  ];

  void onImageChange(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8,
        minChildSize: 0.2,
        maxChildSize: 0.8,
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
              Container(
                height: height * 11 / 16,
                padding: const EdgeInsets.fromLTRB(
                    globalEdgePadding, 0, globalEdgePadding, 0),
                child: InteractiveViewer(
                  child: Image.asset("assets/guide/guide1.png",
                      fit: BoxFit.fitWidth),
                ),
              )
              // Container(
              //   height: height * 11 / 16,
              //   padding: const EdgeInsets.fromLTRB(
              //       globalEdgePadding, 0, globalEdgePadding, 0),
              //   child: PageView.builder(
              //     controller: controller,
              //     itemCount: images.length,
              //     onPageChanged: (int page) {
              //       setState(() {
              //         _currentPage = page;
              //       });
              //     },
              //     itemBuilder: (BuildContext context, int index) {
              //       return InteractiveViewer(child: images[index]);
              //     },
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     const SizedBox(),
              //     IconButton(
              //         onPressed: () {
              //           _currentPage--;
              //           if (_currentPage < 0) {
              //             _currentPage = images.length - 1;
              //           }
              //           onImageChange(_currentPage);
              //           // if (_currentPage > 0) {
              //           //   controller.animateToPage(
              //           //     _currentPage - 1,
              //           //     duration: globalPageViewDuration,
              //           //     curve: Curves.easeInOut,
              //           //   );
              //           //   _currentPage--;
              //           // }
              //         },
              //         icon: const Icon(Icons.keyboard_arrow_left)),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: images.map((Image page) {
              //         int index = images.indexOf(page);
              //         return PageViewerIndicator(
              //           color:
              //               _currentPage == index ? thirtyUIColor : Colors.grey,
              //           index: index,
              //           onImageChange: onImageChange,
              //           controller: controller,
              //         );
              //       }).toList(),
              //     ),
              //     IconButton(
              //         onPressed: () {
              //           _currentPage++;
              //           if (_currentPage >= images.length) {
              //             _currentPage = 0;
              //           }
              //           onImageChange(_currentPage);
              //           // if (_currentPage < images.length - 1) {
              //           //   controller.animateToPage(
              //           //     _currentPage + 1,
              //           //     duration: globalPageViewDuration,
              //           //     curve: Curves.easeInOut,
              //           //   );
              //           //   _currentPage++;
              //           // }
              //         },
              //         icon: const Icon(Icons.keyboard_arrow_right)),
              //     const SizedBox(),
              //   ],
              // ),
            ],
          );
        }));
  }
}

class PageViewerIndicator extends StatelessWidget {
  final Color color;
  final int index;
  final Function(int) onImageChange;
  final PageController controller;
  const PageViewerIndicator(
      {super.key,
      required this.color,
      required this.index,
      required this.controller,
      required this.onImageChange});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.animateToPage(
          index,
          duration: globalPageViewDuration,
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        width: 10.0,
        height: 10.0,
        margin: const EdgeInsets.symmetric(horizontal: 6.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
