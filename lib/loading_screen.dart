import 'package:flutter/material.dart';
import 'package:notepad/home_screen/home_screen.dart';
import 'package:notepad/general_components/main_database_class.dart';
import 'package:provider/provider.dart';
import 'package:notepad/dummy_db.dart';

class LoadingScreen extends StatefulWidget {
  static const screenId = 'loading_screen';

  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  // Open the main Database
  final mainDatabase = NotepadDatabase();

  // TODO: Remove the dummy DB
  _initializeDBAndPushReplacementToHomeScreen() async {
    // Initialize the Database
    await mainDatabase.initializeDatabase();

    // Adding the entries in the dummy db for testing purposes
    for (int i = 0; i < dummyDatabase.length; i++) {
      await mainDatabase.dbInsertNote(dummyDatabase[i]);
    }
    // Push to home screen
    _pushReplacementToHomeScreen();
  }

  _pushReplacementToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Provider(
          create: (context) => mainDatabase,
          child: HomeScreen(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Initialize the main database asynchronously
    _initializeDBAndPushReplacementToHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: Image.asset('images/notepad.jpg')),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
