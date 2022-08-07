import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Set the status bar color to transparent
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.white,
  ));

  runApp(const NotepadApp());
}

class NotepadApp extends StatelessWidget {
  const NotepadApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: LoadingScreen(),
    );
  }
}
