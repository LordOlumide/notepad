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
  @override
  Widget build(BuildContext context) {
    // Prepare the date and time formats with intl
    DateFormat dayDateFormat = DateFormat.yMMMMd('en_US'); // month date, year
    DateFormat hourDateFormat = DateFormat.jm(); // time

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
