import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  final String title;

  Note({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        children: [
          // Heading
          Text(

          ),

          // Body

          // Date Last Edited

        ],
      ),
    );
  }
}
