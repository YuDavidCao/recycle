import 'package:flutter/material.dart';

const double globalEdgePadding = 20.0;

const double globalMarginPadding = 10.0;

const int globalPageTransitionTimer = 200;

const Color sixtyUIColor = Colors.white;

const Color thirtyUIColor = Color(0xFF50C878);

const Color tenUIColor = Colors.amber;

const int classificationWidth = 224;

const int classificiationHeight = 224;

const List<String> classificationLabels = [
  'cardboard',
  'glass',
  'metal',
  'paper',
  'plastic',
  'trash'
];

const LinearGradient goldLinearGradient = LinearGradient(
  begin: Alignment(0, -1),
  end: Alignment(0, 1),
  colors: [
    Color(0xFFFFFF00),
    Color.fromRGBO(230, 188, 107, 1),
  ],
);

const LinearGradient blueLinearGradient = LinearGradient(
  begin: Alignment(0, -1),
  end: Alignment(0, 1),
  colors: [
    tenUIColor,
    thirtyUIColor,
  ],
);
