import 'package:flutter/material.dart';

class Note {
  String title;
  String body;
  DateTime timeLastEdited;
  Color bgColor;

  Note({
    this.title = '',
    this.body = '',
    required this.timeLastEdited,
    required this.bgColor,
  });
}