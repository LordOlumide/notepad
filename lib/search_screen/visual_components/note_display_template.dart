import 'package:flutter/material.dart';
import 'package:notepad/general_components/note_object.dart';
import 'package:notepad/general_components/main_database_class.dart';
import 'package:notepad/general_components/constants.dart';
import 'package:notepad/note_editing_screen/note_editing_screen.dart';

class SearchScreenNoteCard extends StatelessWidget {
  final Note note;
  final Function refreshSearchScreen;
  final NotepadDatabase mainDatabase;

  const SearchScreenNoteCard({
    Key? key,
    required this.note,
    required this.mainDatabase,
    required this.refreshSearchScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    DateTime timeLastEditedDateTime =
        DateTime.fromMillisecondsSinceEpoch(note.timeLastEdited);

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
            builder: (context) => NoteEditingScreen(
                note: note, mainDatabase: mainDatabase)))
            .then((_) => {refreshSearchScreen()});
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
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
                note.title != ''
                    ? note.title
                    : note.body,
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
    );
  }
}
