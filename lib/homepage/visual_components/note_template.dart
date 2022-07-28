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
  bool selectionMode;
  final Function activateSelectionMode;

  NoteCard({
    Key? key,
    required this.note,
    required this.refreshHomePageList,
    required this.selectionMode,
    required this.activateSelectionMode,
  }) : super(key: key);

  // bool whether this card is currently selected or not
  bool isSelected = false;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {

  void toggleSelect() {
    setState(() {
      widget.isSelected = !widget.isSelected;
    });
  }

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
        // If selection mode is false, move to editing screen
        // If selection mode is true, run the toggleSelected function
        if (widget.selectionMode == false) {
          // Get the mainDatabase and push to NoteEditing screen with it.
          // An error prevented me from using Provider to get the DB in NoteEditingScreen.
          NotepadDatabase mainDatabase =
              Provider.of<NotepadDatabase>(context, listen: false);
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => NoteEditingScreen(
                      note: widget.note, mainDatabase: mainDatabase)))
              .then((_) => {widget.refreshHomePageList()});
        } else {
          toggleSelect();
        }
      },
      onLongPress: () {
        // If selection mode is not active, activate it.
        if (widget.selectionMode == false) {
          widget.activateSelectionMode();
        }
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
        decoration: BoxDecoration(
          color: Color(widget.note.bgColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Heading
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      widget.note.title != ''
                          ? widget.note.title
                          : widget.note.body,
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

            // CheckBox for selection. Active and visible only in selection mode
            widget.selectionMode
                ? SizedBox(
                    width: 45,
                    height: 45,
                    child: FittedBox(
                      child: Checkbox(
                        value: widget.isSelected,
                        onChanged: (newValue) {
                          setState(() {
                            toggleSelect();
                          });
                        },
                        activeColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3)),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
