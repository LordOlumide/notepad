import 'package:flutter/material.dart';

class Note {
  String title;
  String body;
  DateTime timeLastEdited;
  final Color bgColor;

  Note({
    this.title = '',
    this.body = '',
    required this.timeLastEdited,
    required this.bgColor,
  });

  updateNote({
    String? newTitle,
    String? newBody,
    required DateTime newTimeLastEdited,
  }) {
    timeLastEdited = newTimeLastEdited;
    title = newTitle ?? title;
    body = newBody ?? body;
  }
}
