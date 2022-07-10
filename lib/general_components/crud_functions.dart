import 'package:flutter/material.dart';
import 'dart:math';

Color returnRandomColor() {
  List<Color> kNoteColorList = [
    Colors.red[100]!,
    Colors.yellow[100]!,
    Colors.blue[100]!,
    Colors.pink[100]!,
    Colors.green[100]!,
  ];
  final random = Random();
  Color chosenColor = kNoteColorList[random.nextInt(kNoteColorList.length)];
  return chosenColor;
}