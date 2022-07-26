import 'package:flutter/material.dart';
import 'package:notepad/general_components/note_object.dart';
import 'package:intl/intl.dart';

// Components
import 'package:notepad/note_editing_screen/visual_components/'
    'normal_appbar.dart';

class NoteEditingScreen extends StatefulWidget {
  final Note note;

  const NoteEditingScreen({Key? key, required this.note}) : super(key: key);

  @override
  State<NoteEditingScreen> createState() => _NoteEditingScreenState();
}

class _NoteEditingScreenState extends State<NoteEditingScreen> {
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
    // Initialize the controllers
    titleController = TextEditingController(text: widget.note.title);
    bodyController = TextEditingController(text: widget.note.body);
  }

  @override
  void dispose() {
    // Dispose the focusNodes
    titleFocusNode.dispose();
    bodyFocusNode.dispose();
    // Dispose the controllers
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Actual time last edited in DateTime format
    DateTime timeLastEditedDateTime =
        DateTime.fromMillisecondsSinceEpoch(widget.note.timeLastEdited);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NormalAppBar(),
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
            onChanged: (newValue) {},
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
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Text(
              widget.note.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Body
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                widget.note.body,
                style: const TextStyle(
                  fontSize: 15.1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
