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
      appBar: NormalAppBar(),
      body: Column(
        children: [
          // Time last edited
          Text(
              '${dayDateFormat.format(timeLastEditedDateTime)} '
                  '${hourDateFormat.format(timeLastEditedDateTime)}',
            style: const TextStyle(),
          ),

          // Title
          Text(
            widget.note.title,
            style: const TextStyle(),
          ),

          // Body
          Text(
            widget.note.body,
            style: const TextStyle(),
          ),
        ],
      ),
    );
  }
}
