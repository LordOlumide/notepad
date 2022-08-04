import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// screens
import 'loading_screen.dart';

// Ideas:
//
// Make the app live on the net. Make it have user accounts.
// Make it able to export as .docx or .pdf
// Each user can store their notes online and sync to it.
// Notes are shareable with links and permissions.
// You can add Team editing. Friend features.
// You can do the write-passing program where in a Team editing note,
// one person must edit the same Document.
// Maybe this shouldn't be a notepad app, but a documents app.


// The main Database is initialized in the Loading Screen.
// The Provider is wrapped around the HomeScreen from the LoadingScreen.

// TODO: Why is Provider not reaching the downstream screens: search screen and noteediting screen?
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Set the status bar color to transparent
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
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
