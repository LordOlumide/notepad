import 'package:flutter/material.dart';
import 'dart:math';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';





Color returnRandomColor() {
  List<Color> kNoteColorList = [
    Colors.red[50]!,
    Colors.yellow[50]!,
    Colors.blue[50]!,
    Colors.pink[50]!,
    Colors.green[50]!,
  ];
  final random = Random();
  Color chosenColor = kNoteColorList[random.nextInt(kNoteColorList.length)];
  return chosenColor;
}