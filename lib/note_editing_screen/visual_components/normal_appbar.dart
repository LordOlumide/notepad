import 'package:flutter/material.dart';

class NormalAppBar extends StatefulWidget implements PreferredSizeWidget {
  final FocusNode titleFocusNode;
  final FocusNode bodyFocusNode;
  bool isEditing;

  NormalAppBar({
    required this.titleFocusNode,
    required this.bodyFocusNode,
    required this.isEditing,
  });

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  State<NormalAppBar> createState() => _NormalAppBarState();
}

class _NormalAppBarState extends State<NormalAppBar> {
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
      elevation: 0,
      backgroundColor: Colors.white,
      title: const Text(
        'Note',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black87,
          fontWeight: FontWeight.w900,
        ),
      ),
      actions: [
        widget.isEditing
            ? IconButton(
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                onPressed: () {
                  widget.bodyFocusNode.unfocus();
                  widget.titleFocusNode.unfocus();
                },
              )
            : IconButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.green,
                ),
                onPressed: () {
                  // TODO: Implement menu
                },
              ),
      ],
    );
  }
}
