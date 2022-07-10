import 'package:flutter/material.dart';
import 'package:notepad/homepage/home_screen.dart';

void main() {
  runApp(const NotepadApp());
}

class NotepadApp extends StatelessWidget {
  const NotepadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}