import 'package:flutter/material.dart';
import 'package:notepad/general_components/note_object.dart';

List<Note> dummyDatabase = [
  Note(
    id: 1,
    title: 'To do list',
    body: '''First Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
      Nam eget urna lacus. Quisque malesuada sollicitudin justo, 
      quis mattis felis elementum quis. Nullam gravida ipsum eget 
      aliquet pellentesque. Sed at risus sed mi ornare pulvinar et 
      sed augue. Mauris vel ligula cursus, fermentum turpis ac''',
    timeLastEdited: DateTime(2022, 7, 11, 17, 30).millisecondsSinceEpoch,
    bgColor: Colors.pink[50]!.value,
  ),
  Note(
    id: 2,
    title: 'Really, the most correct way to wash out hiding lines from jeans',
    body: '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
    Nam eget urna lacus. Quisque malesuada sollicitudin justo, 
    quis mattis felis elementum quis. Nullam gravida ipsum eget 
    aliquet pellentesque. Sed at risus sed mi ornare pulvinar et 
    sed augue. Mauris vel ligula cursus, fermentum turpis ac,''',
    timeLastEdited: DateTime(2022, 7, 11, 17, 30).millisecondsSinceEpoch,
    bgColor: Colors.red[50]!.value,
  ),
  Note(
    id: 3,
    title: 'To do list',
    body: '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
    Nam eget urna lacus. Quisque malesuada sollicitudin justo, 
    quis mattis felis elementum quis. Nullam gravida ipsum eget 
    aliquet pellentesque. Sed at risus sed mi ornare pulvinar et 
    sed augue. Mauris vel ligula cursus, fermentum turpis ac,''',
    timeLastEdited: DateTime(2022, 7, 11, 17, 30).millisecondsSinceEpoch,
    bgColor: Colors.blue[50]!.value,
  ),
  Note(
    id: 4,
    title: '',
    body: '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
    Nam eget urna lacus. Quisque malesuada sollicitudin justo, 
    quis mattis felis elementum quis. Nullam gravida ipsum eget 
    aliquet pellentesque. Sed at risus sed mi ornare pulvinar et 
    sed augue. Mauris vel ligula cursus, fermentum turpis ac,''',
    timeLastEdited: DateTime(2022, 7, 11, 17, 30).millisecondsSinceEpoch,
    bgColor: Colors.red[50]!.value,
  ),
  Note(
    id: 5,
    title: 'Really, the most correct way to wash out hiding lines from jeans',
    body: 'Lorem ipsum',
    timeLastEdited: DateTime(2022, 7, 11, 17, 30).millisecondsSinceEpoch,
    bgColor: Colors.green[50]!.value,
  ),
  Note(
    id: 6,
    title: 'To do list',
    body: '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
    Nam eget urna lacus. Quisque malesuada sollicitudin justo, 
    quis mattis felis elementum quis. Nullam gravida ipsum eget 
    aliquet pellentesque. Sed at risus sed mi ornare pulvinar et 
    sed augue. Mauris vel ligula cursus, fermentum turpis ac,''',
    timeLastEdited: DateTime(2022, 7, 11, 17, 30).millisecondsSinceEpoch,
    bgColor: Colors.black12.value,
  ),
  Note(
    id: 7,
    title: 'Really, the most correct way to wash out hiding lines from jeans',
    body: '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
    Nam eget urna lacus. Quisque malesuada sollicitudin justo, 
    quis mattis felis elementum quis. Nullam gravida ipsum eget 
    aliquet pellentesque. Sed at risus sed mi ornare pulvinar et 
    sed augue. Mauris vel ligula cursus, fermentum turpis ac,''',
    timeLastEdited: DateTime(2022, 7, 11, 17, 30).millisecondsSinceEpoch,
    bgColor: Colors.red[50]!.value,
  ),
  Note(
    id: 8,
    title: 'To do list',
    body: '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
    Nam eget urna lacus. Quisque malesuada sollicitudin justo, 
    quis mattis felis elementum quis. Nullam gravida ipsum eget 
    aliquet pellentesque. Sed at risus sed mi ornare pulvinar et 
    sed augue. Mauris vel ligula cursus, fermentum turpis ac,''',
    timeLastEdited: DateTime(2022, 7, 11, 17, 30).millisecondsSinceEpoch,
    bgColor: Colors.blue[50]!.value,
  ),
  Note(
    id: 9,
    title: '',
    body: '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
    Nam eget urna lacus. Quisque malesuada sollicitudin justo, 
    quis mattis felis elementum quis. Nullam gravida ipsum eget 
    aliquet pellentesque. Sed at risus sed mi ornare pulvinar et 
    sed augue. Mauris vel ligula cursus, fermentum turpis ac,''',
    timeLastEdited: DateTime(2022, 7, 11, 17, 30).millisecondsSinceEpoch,
    bgColor: Colors.red[50]!.value,
  ),
  Note(
    id: 10,
    title: 'Really, the most correct way to wash out hiding lines from jeans',
    body: '''Lorem ipsum''',
    timeLastEdited: DateTime(2022, 7, 11, 17, 30).millisecondsSinceEpoch,
    bgColor: Colors.green[50]!.value,
  ),
  Note(
    id: 11,
    title: 'To do list',
    body: '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
    Nam eget urna lacus. Quisque malesuada sollicitudin justo, 
    quis mattis felis elementum quis. Nullam gravida ipsum eget 
    aliquet pellentesque. Sed at risus sed mi ornare pulvinar et 
    sed augue. Mauris vel ligula cursus, fermentum turpis ac,''',
    timeLastEdited: DateTime(2022, 7, 11, 17, 30).millisecondsSinceEpoch,
    bgColor: Colors.black12.value,
  ),
];
