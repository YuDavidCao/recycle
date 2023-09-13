import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recycle/constants.dart';

import 'package:recycle/pages/home_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/HomePage':
        return PageTransition(
          child: const HomePage(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: globalPageTransitionTimer),
          reverseDuration:
              const Duration(milliseconds: globalPageTransitionTimer),
        );
      default:
        return PageTransition(
          child: const Placeholder(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: globalPageTransitionTimer),
          reverseDuration:
              const Duration(milliseconds: globalPageTransitionTimer),
        );
    }
  }
}
