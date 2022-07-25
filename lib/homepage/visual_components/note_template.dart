import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notepad/homepage/homescreen_constants.dart';
import 'package:notepad/general_components/note_object.dart';
import 'package:notepad/note_editing_screen/note_editing_screen.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Prepare the date and time formats with intl
    DateFormat dayDateFormat = DateFormat.yMMMMd('en_US'); // month date, year
    DateFormat hourDateFormat = DateFormat.jm(); // time

    // Actual time last edited in DateTime format
    DateTime timeLastEditedDateTime =
        DateTime.fromMillisecondsSinceEpoch(note.timeLastEdited);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteEditingScreen(note: note)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(note.bgColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text(
                note.title != '' ? note.title : note.body,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: kTitleTextStyle,
              ),
            ),

            // Body
            note.title != ''
                ? Text(
                    note.body,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kBodyTextStyle,
                  )
                : const SizedBox(),

            // Date Last Edited
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 6),
              child: Text(
                '${dayDateFormat.format(timeLastEditedDateTime)} '
                '${hourDateFormat.format(timeLastEditedDateTime)}',
                style: kDateTimeTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
