import 'package:flutter/material.dart';
import 'package:notepad/homepage/home_screen.dart';
import 'package:provider/provider.dart'; // May not use provider

void main() {
  runApp(NotepadApp());
}

class NotepadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}