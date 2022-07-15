import 'package:flutter/material.dart';
import 'package:notepad/dummy_db.dart';
import 'package:notepad/homepage/visual_components/note_template.dart';

class HomeScreen extends StatelessWidget {
  final scrollController = ScrollController();

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
            child: NestedScrollView(
              controller: scrollController,
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, _) => [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black38,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: const [
                      // search icon
                      Icon(
                        Icons.search,
                        color: Colors.black45,
                      ),
                      // "Search notes" text
                      Text(
                        'Search notes',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                )
              ],
              body: ListView(
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
          ),
        ],
      ),
    );
  }
}
