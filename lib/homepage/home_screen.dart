import 'package:flutter/material.dart';
import 'package:notepad/dummy_db.dart';
import 'package:notepad/homepage/visual_components/note_template.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Notepad Text
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 40, 0, 15),
            child: Text(
              'Notepad',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // The ListView
          ListView(
            children: [
              for (int i = 0; i < database.length; i++)
                Note(
                  title: database[i]['title'],
                  body: database[i]['body'],
                  timeLastEdited: database[i]['timeLastEdited'],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
