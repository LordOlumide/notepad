import 'package:flutter/material.dart';
import 'package:notepad/general_components/main_database_class.dart';
import 'package:notepad/homepage/visual_components/note_template.dart';
import 'package:notepad/general_components/note_object.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// This List is for display purposes only. Not to be edited.
  List<Note> currentNotes = [];

  // To refresh the currentNotes list.
  Future<void> refreshCurrentNotes() async {
    print('before refreshing');
    final tempCurrentNotes =
        await Provider.of<NotepadDatabase>(context, listen: false).getNotes();
    setState(() {
      currentNotes = tempCurrentNotes;
    });
    print('after refreshing');
  }

  @override
  void initState() {
    super.initState();

    refreshCurrentNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Empty appbar to configure the status bar
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Notepad Text
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 70, 15, 15),
            child: Text(
              'Notepad',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // The ScrollView
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                // Floating appbar
                SliverAppBar(
                  backgroundColor: Colors.white,
                  floating: true,
                  elevation: 0,
                  // SearchBar container
                  title: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Processing'),
                              ));
                    }, // Push to search screen
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[100]!,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: const [
                          // search icon
                          Icon(
                            Icons.search,
                            color: Colors.black26,
                          ),
                          SizedBox(width: 10),
                          // "Search notes" text
                          Text(
                            'Search notes',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Main list body
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      return NoteCard(note: currentNotes[i]);
                    },
                    childCount: currentNotes.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
