import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notepad/homepage/homescreen_constants.dart';
import 'package:notepad/general_components/note_object.dart';
import 'package:notepad/note_editing_screen/note_editing_screen.dart';
import 'package:provider/provider.dart';
import 'package:notepad/general_components/main_database_class.dart';

class NoteCard extends StatefulWidget {
  final Note note;
  final Function refreshHomePageList;

  const NoteCard(
      {Key? key, required this.note, required this.refreshHomePageList})
      : super(key: key);

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    // Prepare the date and time formats with intl
    DateFormat dayDateFormat = DateFormat.yMMMMd('en_US'); // month date, year
    DateFormat hourDateFormat = DateFormat.jm(); // time

    // Actual time last edited in DateTime format
    DateTime timeLastEditedDateTime =
        DateTime.fromMillisecondsSinceEpoch(widget.note.timeLastEdited);

    return GestureDetector(
      onTap: () {
        // Get the mainDatabase and push to NoteEditing screen with it.
        // An error prevented me from using Provider to get the DB in NoteEditingScreen.
        NotepadDatabase mainDatabase =
            Provider.of<NotepadDatabase>(context, listen: false);
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => NoteEditingScreen(
                    note: widget.note, mainDatabase: mainDatabase)))
            .then((_) => {
                  // todo: check for empty notes and delete them.
                  widget.refreshHomePageList()
                });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(widget.note.bgColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text(
                widget.note.title != '' ? widget.note.title : widget.note.body,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: kTitleTextStyle,
              ),
            ),

            // Body
            widget.note.title != ''
                ? Text(
                    widget.note.body,
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
