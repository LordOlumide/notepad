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
  // TODO: Ideally, the selectedNotes List will be used to control UI.
  // TODO: If Note is in selectedNotes, isSelected = true, else, false. Alternatively, a Map would be much neater than this.

  /// This List is for display purposes only.
  /// Does not affect the actual Database.
  List<Note> currentNotes = [];

  /// List of the currentStates that control
  /// whether each Note shows as selected or not
  List<bool> currentStates = [];

  /// bool for whether in selection mode or not
  bool selectionMode = false;

  /// bool for whether all notes are selected or not
  bool allNotesAreSelected = false;

  /// List for currently selected notes
  List<Note> selectedNotes = [];

  /// Refreshes the currentNotes and currentStates lists.
  Future<void> refreshCurrentNotes() async {
    // TODO: use notifyListeners to update the currentNotes from the mainDB object??
    List<Note> tempCurrentNotes =
        await Provider.of<NotepadDatabase>(context, listen: false).dbGetNotes();
    // Sort tempNotes
    tempCurrentNotes
        .sort((a, b) => b.timeLastEdited.compareTo(a.timeLastEdited));
    // set the currentStates
    List<bool> tempCurrentStates = [];
    for (int i = 0; i < tempCurrentNotes.length; i++) {
      tempCurrentStates.add(false);
    }
    // refresh the screen
    setState(() {
      currentNotes = tempCurrentNotes;
      currentStates = tempCurrentStates;
    });
  }

  /// Activates selection Mode and set the passed note to selected
  void activateSelectionMode(Note selectionModeActivationNote) {
    setState(() {
      selectionMode = true;
    });
    toggleNoteState(selectionModeActivationNote, isSelectedState: true);
  }

  /// Clears the selectedNotes List and set selectionMode to false
  void deactivateSelectionMode() {
    // clear the current selection
    selectedNotes.clear();
    // set all the currentStates to false
    for (int i = 0; i < currentStates.length; i++) {
      currentStates[i] = false;
    }
    // set selectionMode to false
    setState(() {
      selectionMode = false;
    });
  }

  /// Does not affect UI
  void addToSelectedNotes(Note note) {
    setState(() {
      selectedNotes.add(note);
    });
  }

  /// Does not affect UI
  void removeFromSelectedNotes(Note note) {
    setState(() {
      selectedNotes.remove(note);
    });
  }

  /// Changes the state of the note passed into it. true to false / vice versa.
  /// Optional parameter isSelectedState to set it to a particular bool.
  /// Then, it adds or removes the note from selectedNotes.
  void toggleNoteState(Note note, {bool? isSelectedState}) {
    // Get index of note in question
    int index = currentNotes.indexOf(note);
    // If a bool is passed, set the state to that bool
    // else, invert the current state
    if (isSelectedState != null) {
      setState(() {
        currentStates[index] = isSelectedState;
      });
    } else {
      setState(() {
        currentStates[index] = !currentStates[index];
      });
    }
    // Add the note to selectedNotes if selected, else remove
    if (currentStates[index] == true) {
      addToSelectedNotes(note);
    } else {
      removeFromSelectedNotes(note);
    }
    // Check to see if all notes are selected
    if (selectedNotes.length == currentNotes.length) {
      setState(() {
        allNotesAreSelected = true;
      });
    } else {
      setState(() {
        allNotesAreSelected = false;
      });
    }
  }

  // TODO: You'll have to update the noteCards with the selectedNotes List.
  // TODO: Maybe create an interface class, maybe not

  void toggleAllNotesSelection() {
    setState(() {
      allNotesAreSelected = !allNotesAreSelected;
    });
    if (allNotesAreSelected == true) {
      // remove every note already selected from selectedNotes, then add every note to it
      selectedNotes.clear();
      for (Note i in currentNotes) {
        setState(() {
          addToSelectedNotes(i);
        });
      }
      // Update  UI
      setState(() {
        for (int i = 0; i < currentStates.length; i++) {
          currentStates[i] = true;
        }
      });
    } else {
      setState(() {
        selectedNotes.clear();
      });
      // Update  UI
      setState(() {
        for (int i = 0; i < currentStates.length; i++) {
          currentStates[i] = false;
        }
      });
    }
  }

  Future<void> deleteSelectedNotesFromDB(List<Note> notesToDelete) async {
    List<Note> tempNotesToDelete = [...notesToDelete];
    for (Note note in tempNotesToDelete) {
      selectedNotes.remove(note);
      if (mounted) {
        await Provider.of<NotepadDatabase>(context, listen: false)
            .dbDeleteNote(note.id);
      }
    }
    refreshCurrentNotes();
  }

  int getNewId() {
    // TODO: Make this algorithm better and more efficient. It doesn't account for deleted Notes.
    // Maybe find a UUID package.
    List<int> listOfActiveIds = [];
    for (Note i in currentNotes) {
      listOfActiveIds.add(i.id);
    }
    listOfActiveIds.sort((a, b) => a.compareTo(b));
    return listOfActiveIds.isNotEmpty ? listOfActiveIds.last + 1 : 1;
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

    return WillPopScope(
      onWillPop: () async {
        // trying to pop the screen in selectionMode will deactivate selection mode,
        // in normal mode, will pop normally.
        if (selectionMode == true) {
          deactivateSelectionMode();
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: selectionMode == false
            // Empty appbar to configure the status bar
            ? AppBar(
                toolbarHeight: 0,
                backgroundColor: Colors.white,
                elevation: 0,
                automaticallyImplyLeading: false,
              )
            // Real appbar that activates in select mode
            : AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.green,
                    size: 28,
                  ),
                  onPressed: () {
                    deactivateSelectionMode();
                  },
                ),
                titleTextStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
                titleSpacing: 4,
                // Display the number of selected items if any items are selected
                title: selectedNotes.isEmpty
                    ? const Text('Please select items')
                    : selectedNotes.length == 1
                        ? const Text('1 item selected')
                        : Text('${selectedNotes.length} items selected'),
                backgroundColor: Colors.white,
                elevation: 0,
                toolbarHeight: 50,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Checkbox(
                      value: allNotesAreSelected,
                      onChanged: (_) {
                        toggleAllNotesSelection();
                      },
                      activeColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                    ),
                  ),
                ],
              ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notepad Text
            Padding(
              padding: selectionMode == false
                  ? const EdgeInsets.fromLTRB(15, 60, 15, 15)
                  : const EdgeInsets.fromLTRB(15, 10, 15, 15),
              child: const Text(
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
                          color: selectionMode == false
                              ? Colors.grey[100]
                              : Colors.grey[50],
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            // search icon
                            Icon(
                              Icons.search,
                              color: selectionMode == false
                                  ? Colors.black26
                                  : Colors.black12,
                            ),
                            const SizedBox(width: 10),
                            // "Search notes" text
                            Text(
                              'Search notes',
                              style: TextStyle(
                                color: selectionMode == false
                                    ? Colors.black45
                                    : Colors.black12,
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
                          refreshHomePage: refreshCurrentNotes,
                          selectionMode: selectionMode,
                          isSelected: currentStates[i],
                          activateSelectionMode: activateSelectionMode,
                          toggleNoteState: toggleNoteState,
                        );
                      },
                      childCount: currentNotes.length,
                    ),
                  ),
                ],
              ),
            ),

            // The bottom delete button only enabled if in selection mode
            selectionMode == false
                ? const SizedBox()
                : GestureDetector(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (context) => const Dialog(child: Text('Dialog')),
                      );
                      if (selectedNotes.isNotEmpty) {
                        deleteSelectedNotesFromDB(selectedNotes);
                        deactivateSelectionMode();
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete_outline,
                            color: selectedNotes.isEmpty
                                ? Colors.black26
                                : Colors.black54,
                          ),
                          Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: selectedNotes.isEmpty
                                  ? Colors.black26
                                  : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: selectionMode == false
            ? SizedBox(
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
                      // refresh the HomeScreen
                      await refreshCurrentNotes();
                    },
                    backgroundColor: Colors.green,
                    tooltip: 'Create a new note',
                    child: const Icon(Icons.add),
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
