import 'package:flutter/material.dart';

class NormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final FocusNode titleFocusNode;
  final FocusNode bodyFocusNode;

  const NormalAppBar({
    required this.titleFocusNode,
    required this.bodyFocusNode
  });

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.green,
          size: 28,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      titleSpacing: 4,
      title: const Text(
        'Note',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black87,
          fontWeight: FontWeight.w900,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.more_vert,
            color: Colors.green,
          ),
          onPressed: () {
            bodyFocusNode.unfocus();
            titleFocusNode.unfocus();
          },
        ),
      ],
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }
}
