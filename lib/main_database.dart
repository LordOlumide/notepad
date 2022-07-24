import 'package:flutter/material.dart';
import 'dart:math';
import 'package:notepad/general_components/note_object.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotepadDatabase {
  late final Future<Database> database;

  // creates the "notes" database if it doesn't exist already
  initializeDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = openDatabase(
      join(await getDatabasesPath(), 'notepad_database.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE notes('
            'id INTEGER PRIMARY KEY, title TEXT, body TEXT, '
            'timeLastEdited INTEGER, bgColor TEXT)');
      },
      version: 1,
    );
  }

  // Inserts a new note into the "notes" database
  Future<void> insertNote(Note note) async {
    final db = await database;

    await db.insert('notes', note.toMap());
  }

  // Returns a list of all the notes in the "notes" database
  Future<List<Note>> notes() async {
    final db = await database;

    final List<Map<String, dynamic>> notesMap = await db.query('notes');
    return List.generate(
        notesMap.length,
        (index) => Note(
              id: notesMap[index]['id'],
              title: notesMap[index]['title'],
              body: notesMap[index]['body'],
              timeLastEdited: notesMap[index]['timeLastEdited'],
              bgColor: notesMap[index]['bgColor'],
            ));
  }

  // Updates a note in the "notes" database
  Future<void> updateNote(Note note) async {
    final db = await database;

    await db.update(
      "notes",
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  //TODO: if title == "" & body == "", delete that note
  // Deletes a note from the "notes" database
  Future<void> deleteNote(int id) async {
    final db = await database;

    await db.delete(
      'notes',
      where: 'id: ?',
      whereArgs: [id],
    );
  }
}

Color returnRandomColor() {
  List<Color> kNoteColorList = [
    Colors.red[50]!,
    Colors.yellow[50]!,
    Colors.blue[50]!,
    Colors.pink[50]!,
    Colors.green[50]!,
  ];
  final random = Random();
  Color chosenColor = kNoteColorList[random.nextInt(kNoteColorList.length)];
  return chosenColor;
}
