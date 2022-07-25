import 'package:flutter/material.dart';
import 'loading_screen.dart';
import 'package:flutter/services.dart';

// Note: The main Database is initialized in the Loading Screen.
// The Provider is wrapped around the HomeScreen from the LoadingScreen.

void main() {
  // Set the status bar color to transparent
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

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
