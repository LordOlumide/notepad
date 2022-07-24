import 'package:flutter/material.dart';

class Note {
  final int id;
  String title;
  String body;
  int timeLastEdited; // DateTime.millisecondsSinceEpoch
  final int bgColor;

  Note({
    required this.id,
    this.title = '',
    this.body = '',
    required this.timeLastEdited,
    required this.bgColor,
  });

  // Updates the Note
  updateNote({
    String? newTitle,
    String? newBody,
    required int newTimeLastEdited,
  }) {
    timeLastEdited = newTimeLastEdited;
    title = newTitle ?? title;
    body = newBody ?? body;
  }

  // Converts the Note object to a Map for the database
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'timeLastEdited': timeLastEdited,
      'bgColor': bgColor,
    };
  }

  // Implements toString() to make it easier to display each Note with Print()
  @override
  String toString() {
    return 'Note{'
        'title: ${title.substring(0, title.length > 25 ? 25 : null)}, '
        'body: ${body.substring(0, body.length > 25 ? 25 : null)}, '
        'timeLastEdited: $timeLastEdited, '
        'bgColor: $bgColor'
        '}';
  }
}
