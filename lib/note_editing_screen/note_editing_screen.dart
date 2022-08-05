import 'package:flutter/material.dart';
import 'package:notepad/general_components/main_database_class.dart';
import 'package:notepad/general_components/note_object.dart';
import 'package:notepad/general_components/constants.dart';
// widgets
import 'package:notepad/note_editing_screen/widgets/'
    'normal_appbar.dart';

class NoteEditingScreen extends StatefulWidget {
  static const screenId = 'note_editing_screen';

  final Note note;
  final NotepadDatabase mainDatabase;
  // It appears I have to pass the mainDatabase as an argument instead of just
  // accessing it with Provider because I didn't provide the Provider at the
  // MaterialApp level. Navigator is Linked to the MaterialApp.
  // Meanwhile, I can't provide at the material app level because I must
  // initialize the Database before providing.
  // There should be a way to fix it by removing the loadingScreen and
  // working it out in main.dart.

  const NoteEditingScreen(
      {Key? key, required this.note, required this.mainDatabase})
      : super(key: key);

  @override
  State<NoteEditingScreen> createState() => _NoteEditingScreenState();
}

class _NoteEditingScreenState extends State<NoteEditingScreen> {
  // bool to control the viewing mode
  bool isEditing = false;

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

  void deleteThisNote() async {
    print('triggered');
    print(context);
    // return true to delete, false to cancel
    switch (await showDialog<bool> (context: context, builder: (BuildContext context) {
      print ('entered');
      return Container(
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Text(
                  'Delete note',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // body
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Text(
                  'Are you sure you want to delete this note?',
                  style: TextStyle(
                    fontSize: 14.5,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w400
                  ),
                ),
              ),

              const Divider(height: 1),

              // actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel button
                  MaterialButton(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  // Delete button
                  MaterialButton(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text(
                      'DELETE',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    })) {
      case true:
        await widget.mainDatabase.dbDeleteNote(widget.note.id);
        if (mounted) {
          Navigator.of(context).pop();
        }
        break;
      case false:
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Actual time last edited in DateTime format
    DateTime timeLastEditedDateTime =
        DateTime.fromMillisecondsSinceEpoch(widget.note.timeLastEdited);

    return WillPopScope(
      onWillPop: () async {
        if (widget.note.title == '' && widget.note.body == '') {
          await widget.mainDatabase.dbDeleteNote(widget.note.id);
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: NormalAppBar(
          // Passing the focusNodes to the appbar to control which icon shows
          titleFocusNode: titleFocusNode,
          bodyFocusNode: bodyFocusNode,
          isEditing: isEditing,
          deleteThisNote: deleteThisNote,
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

            // TODO: delete this
            MaterialButton(
              onPressed: () {
                deleteThisNote();
              },
              child: Text('test'),
            )
          ],
        ),
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
