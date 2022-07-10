import 'package:flutter/material.dart';
import 'package:notepad/dummy_db.dart';
import 'package:notepad/homepage/visual_components/note_template.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Notepad Text
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 70, 15, 10),
            child: Text(
              'Notepad',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // The ListView
          Expanded(
            child: ListView(
              children: [
                for (int i = 0; i < database.length; i++)
                  Note(
                    title: database[i]['title'],
                    body: database[i]['body'],
                    bgColor: database[i]['bgColor'],
                    timeLastEdited: database[i]['timeLastEdited'],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
