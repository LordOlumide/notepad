import 'package:flutter/material.dart';
import 'package:notepad/dummy_db.dart';
import 'package:notepad/homepage/visual_components/note_template.dart';
import 'package:notepad/general_components/note_object.dart';
import 'package:notepad/general_components/main_database.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final mainDatabase = NotepadDatabase();

  initializeDB() async {
    await mainDatabase.initializeDatabase();

    // add the entries in the dummy db
    for (int i = 0; i < dummyDatabase.length; i++) {
      await mainDatabase.insertNote(dummyDatabase[i]);
    }

    // check that entering the entries worked
    final List<Note> dummyEntries = await mainDatabase.getNotes();
    for (Note i in dummyEntries) {
      print(i.toString());
    }

    // set the currentNotes List
    await refreshCurrentNotes();
  }

  @override
  void initState() {
    super.initState();
    initializeDB();
  }

  /// This List is for display purposes only. Not to be edited.
  List<Note> currentNotes = [];

  // To refresh the currentNotes list.
  Future<void> refreshCurrentNotes() async {
    currentNotes = await mainDatabase.getNotes();
  }

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
                        title: currentNotes[i].title,
                        body: currentNotes[i].body,
                        bgColorIntValue: currentNotes[i].bgColor,
                        timeLastEdited: DateTime.fromMillisecondsSinceEpoch(
                            currentNotes[i].timeLastEdited),
                      );
                    },
                    childCount: currentNotes.length,
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
