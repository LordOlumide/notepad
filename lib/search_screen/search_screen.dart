import 'package:flutter/material.dart';
import 'package:notepad/general_components/note_object.dart';
import 'package:notepad/general_components/main_database_class.dart';
import 'visual_components/note_display_template.dart';

class SearchScreen extends StatefulWidget {
  static const screenId = 'search_screen';

  final NotepadDatabase mainDatabase;

  const SearchScreen({
    Key? key,
    required this.mainDatabase,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;

  /// Contains the current list of Notes that fit the query
  List<Note> currentBuild = [];

  // TODO: test your query algorithm with 10,000 notes
  Future<void> queryDatabase(String queryTerm) async {
    if (queryTerm == '') {
      setState(() {
        currentBuild = [];
      });
    } else {
      List<Note> results = await widget.mainDatabase.dbQueryNotes(queryTerm);
      setState(() {
        currentBuild = results;
      });
    }
  }

  void refreshSearchScreen() async {
    queryDatabase(_controller.text);
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.green,
              size: 27,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        leadingWidth: 38,
        title: SizedBox(
          height: 38,
          child: TextField(
            controller: _controller,
            onChanged: (String text) {
              queryDatabase(text);
            },
            autofocus: true,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.withOpacity(0.14),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              hintText: 'Search notes',
              hintStyle: const TextStyle(
                color: Colors.black38,
                fontSize: 18,
                height: 2.5,
              ),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 18, right: 5),
                child: Icon(
                  Icons.search,
                  color: Colors.black12,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _controller.clear();
                  refreshSearchScreen();
                },
                color: Colors.black45,
                icon: const Icon(Icons.cancel),
              ),
            ),
            style: const TextStyle(
              height: 1.3,
              fontSize: 17,
            ),
            cursorHeight: 23,
            cursorWidth: 2.0,
            cursorColor: Colors.green,
          ),
        ),
      ),
      body: ListView(
        children: [
          // whitespace
          const SizedBox(height: 60),

          // The note cards
          for (Note i in currentBuild)
            SearchScreenNoteCard(
              note: i,
              mainDatabase: widget.mainDatabase,
              refreshSearchScreen: refreshSearchScreen,
            ),
        ],
      ),
    );
  }
}
