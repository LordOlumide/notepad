import 'package:flutter/material.dart';
import 'package:notepad/general_components/note_object.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotepadDatabase {
  // It is private so it can only be accessed by the defined CRUD functions
  late final Future<Database> _database;

  // creates the "notes" database if it doesn't exist already
  initializeDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();

    // TODO: The database will have to be stabilized after getting rid of the dummyDB. No more delete-recreate.
    // delete the previous database
    deletePreexistingDatabase(
        join(await getDatabasesPath(), 'notepad_database.db'));

    // create the database afresh.
    _database = openDatabase(
      join(await getDatabasesPath(), 'notepad_database.db'),
      onCreate: (db, version) {
        //TODO: change the id to AUTOINCREMENT.
        return db.execute('CREATE TABLE notes('
            'id INTEGER PRIMARY KEY, title TEXT, body TEXT, '
            'timeLastEdited INTEGER, bgColor INTEGER)');
      },
      version: 1,
    );
  }

  // Inserts a new note into the "notes" database
  Future<void> dbInsertNote(Note note) async {
    final db = await _database;

    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Returns a list of all the notes in the "notes" database sorted by timeLastEdited
  Future<List<Note>> dbGetNotes() async {
    final db = await _database;

    final List<Map<String, dynamic>> notesMap = await db.query('notes');
    List<Note> returnListOfNotes = List.generate(
      notesMap.length,
      (index) => Note(
        id: notesMap[index]['id'],
        title: notesMap[index]['title'],
        body: notesMap[index]['body'],
        timeLastEdited: notesMap[index]['timeLastEdited'],
        bgColor: notesMap[index]['bgColor'],
      ),
    );
    returnListOfNotes
        .sort((a, b) => b.timeLastEdited.compareTo(a.timeLastEdited));
    return returnListOfNotes;
  }

  // Updates a note in the "notes" database
  Future<void> dbUpdateNote(Note note) async {
    final db = await _database;

    await db.update(
      "notes",
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  //TODO: if title == "" & body == "", delete that note
  // Deletes a note from the "notes" database
  Future<void> dbDeleteNote(int id) async {
    final db = await _database;

    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// For development purposes
  Future<void> deletePreexistingDatabase(String path) async {
    // final db = await database;
    // // Deletes the notes database if it exists.
    // db.execute('DROP TABLE IF EXISTS notes');

    databaseFactory.deleteDatabase(path);
  }
}
