import 'package:flutter/material.dart';
import 'package:notepad/UI/screens/home_screen/home_screen.dart';
import 'package:notepad/UI/general_components/main_database_class.dart';
import 'package:get/get.dart';
import 'package:notepad/dummy_db.dart';

class LoadingScreen extends StatefulWidget {
  static const screenId = 'loading_screen';

  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  // Open the main Database
  final NotepadDatabaseHelper mainDatabase = Get.put(NotepadDatabaseHelper());

  // TODO: Remove the dummy DB
  _initializeDBAndPushReplacementToHomeScreen() async {
    // Initialize the Database
    await mainDatabase.initializeDatabase();

    // // TODO: remove dummyDB addition
    // // Adding the entries in the dummy db for testing purposes
    // for (int i = 0; i < dummyDatabase.length; i++) {
    //   await mainDatabase.dbInsertNote(dummyDatabase[i]);
    // }
    // Push to home screen
    _pushReplacementToHomeScreen();
  }

  _pushReplacementToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
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
