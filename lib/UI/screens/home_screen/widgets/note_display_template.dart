import 'package:flutter/material.dart';
import 'package:notepad/UI/general_components/note_object.dart';
import 'package:notepad/UI/screens/note_editing_screen/note_editing_screen.dart';
import 'package:notepad/UI/general_components/constants.dart';

class HomeScreenNoteCard extends StatelessWidget {
  final Note note;
  final Function refreshHomePage;
  bool selectionMode;
  bool isSelected;
  final Function activateSelectionMode;
  final Function toggleNoteState;

  HomeScreenNoteCard({
    Key? key,
    required this.note,
    required this.refreshHomePage,
    required this.selectionMode,
    required this.isSelected,
    required this.activateSelectionMode,
    required this.toggleNoteState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    DateTime timeLastEditedDateTime =
        DateTime.fromMillisecondsSinceEpoch(note.timeLastEdited);

    void onNormalModeTap() {
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (context) => NoteEditingScreen(note: note)))
          .then((_) => {refreshHomePage()});
    }

    void onSelectionModeTap() {
      toggleNoteState(note);
    }

    return GestureDetector(
      onTap: () {
        // If selection mode is false, move to editing screen
        // If selection mode is true, run the toggleSelected function
        if (selectionMode == false) {
          onNormalModeTap();
        } else {
          onSelectionModeTap();
        }
      },
      onLongPress: () {
        // If selection mode is not active, activate it
        // and set this card to selected
        if (selectionMode == false) {
          activateSelectionMode(note);
        }
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
        decoration: BoxDecoration(
          color: Color(note.bgColor),
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
                      note.title != '' ? note.title : note.body,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kTitleTextStyle,
                    ),
                  ),

                  // Body
                  note.title != ''
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            note.body,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: kBodyTextStyle,
                          ),
                        )
                      : const SizedBox(),

                  // Date Last Edited
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 6),
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
            selectionMode
                ? SizedBox(
                    width: 45,
                    height: 45,
                    child: FittedBox(
                      child: Checkbox(
                        value: isSelected,
                        onChanged: (_) {
                          onSelectionModeTap();
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
