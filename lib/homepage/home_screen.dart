import 'package:flutter/material.dart';
import 'package:notepad/general_components/main_database_class.dart';
import 'package:notepad/homepage/visual_components/note_template.dart';
import 'package:notepad/general_components/note_object.dart';
import 'package:notepad/note_editing_screen/note_editing_screen.dart';
import 'package:provider/provider.dart';
import 'package:notepad/general_components/miscellaneous_functions.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool selectionMode = false;

  /// Activates select mode
  void activateSelectionMode() {
    setState(() {
      selectionMode = true;
    });
  }

  /// This List is for display purposes only.
  /// Does not affect the actual Database.
  List<Note> currentNotes = [];

  /// Deletes empty notes and refreshes the currentNotes list.
  Future<void> refreshCurrentNotes() async {
    // TODO: use notifyListeners to update the currentNotes from the mainDB object
    List<Note> tempCurrentNotes =
        await Provider.of<NotepadDatabase>(context, listen: false).dbGetNotes();

    // TODO: Find another way to delete notes without checking every note.
    // Deleting empty notes
    List<Note> notesToBeRemoved = [];
    // select the empty notes
    for (Note i in tempCurrentNotes) {
      if (i.title == '' && i.body == '') {
        notesToBeRemoved.add(i);
      }
    }
    // remove the deleted note from tempNotes
    for (Note i in notesToBeRemoved) {
      // remove from database
      if (mounted) {
        await Provider.of<NotepadDatabase>(context, listen: false).dbDeleteNote(i.id);
      } else {
        // TODO: delete all print statements in the app. Maybe delete this recursion.
        print('Problem with buildContext across async gap. Re-trying...');
        refreshCurrentNotes();
      }
      // remove from display list
      tempCurrentNotes.remove(i);
    }

    // Sort tempNotes and refresh the screen
    tempCurrentNotes
        .sort((a, b) => b.timeLastEdited.compareTo(a.timeLastEdited));
    setState(() {
      currentNotes = tempCurrentNotes;
    });
  }

  /// gets all current IDs, sorts them in a list,
  /// returns 'the last item in the list' + 1.
  int getNewId() {
    // TODO: Make this algorithm more efficient. It doesn't account for deleted Notes.
    // Use a UUID package.
    List<int> listOfActiveIds = [];
    for (Note i in currentNotes) {
      listOfActiveIds.add(i.id);
    }
    listOfActiveIds.sort((a, b) => a.compareTo(b));
    return listOfActiveIds.last + 1;
  }

  @override
  void initState() {
    super.initState();

    refreshCurrentNotes();
  }

  @override
  Widget build(BuildContext context) {

    /// Pushes to the EditingScreen
    Future<void> pushToEditingScreen(Note newNote) {
      final mainDatabase = Provider.of<NotepadDatabase>(context, listen: false);
      return Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NoteEditingScreen(
                note: newNote,
                mainDatabase: mainDatabase,
              )));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      // Empty appbar to configure the status bar
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Notepad Text
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 70, 15, 15),
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
                  backgroundColor: Colors.white,
                  floating: true,
                  elevation: 0,
                  // TODO: implement search bar
                  // SearchBar container
                  title: GestureDetector(
                    onTap: () {}, // Push to search screen
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[100]!,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: const [
                          // search icon
                          Icon(
                            Icons.search,
                            color: Colors.black26,
                          ),
                          SizedBox(width: 10),
                          // "Search notes" text
                          Text(
                            'Search notes',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Main list body
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      return NoteCard(
                        note: currentNotes[i],
                        refreshHomePageList: refreshCurrentNotes,
                        selectionMode: selectionMode,
                        activateSelectionMode: activateSelectionMode,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 50,
        height: 50,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () async {
              // creates a new empty Note object
              int newId = getNewId();
              Note newNote = Note(
                id: newId,
                timeLastEdited: DateTime.now().millisecondsSinceEpoch,
                bgColor: getRandomColor().value,
              );
              // adds the newNote to the Database
              await Provider.of<NotepadDatabase>(context, listen: false)
                  .dbInsertNote(newNote);
              // pushes to noteEditing screen
              await pushToEditingScreen(newNote);
              refreshCurrentNotes();
            },
            backgroundColor: Colors.green,
            tooltip: 'Create a new note',
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
