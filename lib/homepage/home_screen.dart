import 'package:flutter/material.dart';
import 'package:notepad/dummy_db.dart';
import 'package:notepad/homepage/visual_components/note_template.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Notepad Text
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 120, 15, 15),
            child: Text(
              'Notepad',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // The ScrollView
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                // Floating appbar
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  floating: true,
                  elevation: 0,
                  // SearchBar container
                  title: GestureDetector(
                    onTap: () {}, // Push to search screen
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200]!,
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
                    ),
                  ),
                ),

                // body
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      return NoteCard(
                        title: dummyDatabase[i].title,
                        body: dummyDatabase[i].body,
                        bgColor: dummyDatabase[i].bgColor,
                        timeLastEdited: DateTime.fromMillisecondsSinceEpoch(
                            dummyDatabase[i].timeLastEdited),
                      );
                    },
                    childCount: dummyDatabase.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
