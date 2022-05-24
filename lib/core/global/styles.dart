import 'package:flutter/material.dart';

class SubtitleStyle extends TextStyle {
  final double size;
  final Color color;
  final FontWeight fontWeight;

  const SubtitleStyle(
      {this.size = 14,
      this.color = Colors.grey,
      this.fontWeight = FontWeight.normal})
      : super(
          color: color,
          fontWeight: fontWeight,
          fontSize: size,
        );
}

class TitleStyle extends TextStyle {
  final double size;
  final Color color;

  const TitleStyle({this.size = 22, this.color = Colors.black})
      : super(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: size,
        );
}
