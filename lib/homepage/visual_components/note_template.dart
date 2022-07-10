import 'package:flutter/material.dart';
import 'package:notepad/homepage/constants.dart';

class Note extends StatelessWidget {
  final String title;
  final String body;
  final DateTime timeLastEdited;

  const Note({
    Key? key,
    required this.title,
    required this.body,
    required this.timeLastEdited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // Heading
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Text(
              title != '' ? title : body,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: kTitleTextStyle,
            ),
          ),

          // Body
          title != ''
              ? Text(
                  body,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: kBodyTextStyle,
                )
              : const SizedBox(),

          // Date Last Edited
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              timeLastEdited.toString(),
              style: kDateTimeTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
