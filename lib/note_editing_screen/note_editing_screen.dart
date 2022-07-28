import 'package:flutter/material.dart';
import 'package:notepad/general_components/main_database_class.dart';
import 'package:notepad/general_components/note_object.dart';
import 'package:intl/intl.dart';

// Components
import 'package:notepad/note_editing_screen/visual_components/'
    'normal_appbar.dart';

class NoteEditingScreen extends StatefulWidget {
  final Note note;
  final NotepadDatabase mainDatabase;

  const NoteEditingScreen(
      {Key? key, required this.note, required this.mainDatabase})
      : super(key: key);

  @override
  State<NoteEditingScreen> createState() => _NoteEditingScreenState();
}

class _NoteEditingScreenState extends State<NoteEditingScreen> {
  // bool to control the viewing mode
  bool isEditing = false;

  // Prepare the date and time formats with intl
  DateFormat dayDateFormat = DateFormat.yMMMMd('en_US'); // month date, year
  DateFormat hourDateFormat = DateFormat.jm(); // time

  // FocusNodes to control focus
  late FocusNode titleFocusNode;
  late FocusNode bodyFocusNode;

  // TextEditingControllers to set the initial text
  late TextEditingController titleController;
  late TextEditingController bodyController;

  @override
  void initState() {
    super.initState();
    // Initialize the focusNodes
    titleFocusNode = FocusNode();
    bodyFocusNode = FocusNode();
    // adding listeners to the focusNodes
    titleFocusNode.addListener(changeMode);
    bodyFocusNode.addListener(changeMode);
    // Initialize the controllers
    titleController = TextEditingController(text: widget.note.title);
    bodyController = TextEditingController(text: widget.note.body);
  }

  void changeMode() {
    if (bodyFocusNode.hasFocus || titleFocusNode.hasFocus) {
      setState(() {isEditing = true;});
    } else {
      setState(() {isEditing = false;});
    }
  }

  @override
  Widget build(BuildContext context) {
    // Actual time last edited in DateTime format
    DateTime timeLastEditedDateTime =
        DateTime.fromMillisecondsSinceEpoch(widget.note.timeLastEdited);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NormalAppBar(
        // Passing the focusNodes to the appbar to control which icon shows
        titleFocusNode: titleFocusNode,
        bodyFocusNode: bodyFocusNode,
        isEditing: isEditing,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time last edited
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 18, 15, 10),
            child: Text(
              '${dayDateFormat.format(timeLastEditedDateTime)} '
              '${hourDateFormat.format(timeLastEditedDateTime)}',
              style: const TextStyle(
                fontSize: 16.5,
              ),
            ),
          ),

          // Title textField
          TextField(
            onChanged: (newValue) async {
              if (newValue != widget.note.title) {
                // Created an updated note object
                Note noteTempForUpdate = widget.note;
                noteTempForUpdate.updateNote(
                  newTimeLastEdited: DateTime.now().millisecondsSinceEpoch,
                  newTitle: newValue,
                );
                // Update the database with the updated note object
                await widget.mainDatabase.dbUpdateNote(noteTempForUpdate);
              }
            },
            focusNode: titleFocusNode,
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Title',
              hintStyle: TextStyle(
                fontSize: 21,
                color: Colors.black38,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              border: InputBorder.none,
            ),
            cursorColor: Colors.green,
            cursorHeight: 30,
            cursorWidth: 1.5,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
            textCapitalization: TextCapitalization.sentences,
            maxLines: null,
          ),

          // Body textField
          Expanded(
            child: TextField(
              onChanged: (newValue) async {
                if (newValue != widget.note.body) {
                  // Created an updated note object
                  Note noteTempForUpdate = widget.note;
                  noteTempForUpdate.updateNote(
                    newTimeLastEdited: DateTime.now().millisecondsSinceEpoch,
                    newBody: newValue,
                  );
                  // Update the database with the updated note object
                  await widget.mainDatabase.dbUpdateNote(noteTempForUpdate);
                }
              },
              focusNode: bodyFocusNode,
              controller: bodyController,
              decoration: const InputDecoration(
                hintText: 'Note something down',
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black38,
                  height: 1.5,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                border: InputBorder.none,
              ),
              cursorColor: Colors.green,
              cursorHeight: 30,
              cursorWidth: 1.5,
              style: const TextStyle(
                fontSize: 15.1,
                height: 1.5,
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // remove the listener
    titleFocusNode.removeListener(changeMode);
    // Dispose the focusNodes
    titleFocusNode.dispose();
    bodyFocusNode.dispose();
    // Dispose the controllers
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

}
