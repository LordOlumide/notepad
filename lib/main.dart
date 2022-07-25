import 'package:flutter/material.dart';
import 'package:notepad/general_components/main_database_class.dart';
import 'package:provider/provider.dart';
import 'package:notepad/dummy_db.dart';
import 'general_components/note_object.dart';

// screens
import 'loading_screen.dart';
import 'package:notepad/homepage/home_screen.dart';

void main() {
  runApp(NotepadApp());
}

class NotepadApp extends StatefulWidget {
  @override
  State<NotepadApp> createState() => _NotepadAppState();
}

class _NotepadAppState extends State<NotepadApp> {
  // Open the main Database
  final mainDatabase = NotepadDatabase();

  initializeDB() async {
    print('before initializing DB');
    await mainDatabase.initializeDatabase();

    print('After initalizing DB');
    // add the entries in the dummy db for testing purposes
    for (int i = 0; i < dummyDatabase.length; i++) {
      await mainDatabase.insertNote(dummyDatabase[i]);
    }
    print("After adding dummies");

    // test if it's working
    for (Note i in await mainDatabase.getNotes()) {
      print(i.toString());
    }
    print('After testing');
  }

  @override
  void initState() {
    super.initState();
    print('Created main DB');

    // Initialize the main database asynchronously
    initializeDB();

    // Push to home screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Provider(
          create: (context) => mainDatabase,
          child: MaterialApp(
            home: HomeScreen(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingScreen();
  }
}
