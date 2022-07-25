import 'package:flutter/material.dart';
import 'loading_screen.dart';

// Note: The main Database is initialized in the Loading Screen.
// The Provider is wrapped around the HomeScreen from the LoadingScreen.

void main() {
  runApp(NotepadApp());
}

class NotepadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoadingScreen(),
    );
  }
}
