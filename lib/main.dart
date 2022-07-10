import 'package:flutter/material.dart';
import 'package:notepad/homepage/home_screen.dart';

void main() {
  runApp(NotepadApp());
}

class NotepadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}