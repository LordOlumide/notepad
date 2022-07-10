import 'package:flutter/material.dart';
import 'package:notepad/homepage/constants.dart';
import 'package:intl/intl.dart';

class Note extends StatelessWidget {
  final String title;
  final String body;
  final Color bgColor;
  final DateTime timeLastEdited;

  const Note({
    Key? key,
    required this.title,
    required this.body,
    required this.bgColor,
    required this.timeLastEdited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            padding: const EdgeInsets.only(top: 15, bottom: 6),
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
