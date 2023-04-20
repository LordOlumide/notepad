import 'package:flutter/material.dart';

class NormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final FocusNode titleFocusNode;
  final FocusNode bodyFocusNode;
  bool isEditing;
  final Function deleteThisNote;

  NormalAppBar({
    required this.titleFocusNode,
    required this.bodyFocusNode,
    required this.isEditing,
    required this.deleteThisNote,
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
        isEditing
            ? IconButton(
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                onPressed: () {
                  bodyFocusNode.unfocus();
                  titleFocusNode.unfocus();
                },
              )
            : PopupMenuButton(
                padding: const EdgeInsets.all(0),
                offset: const Offset(0, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.green,
                ),
                itemBuilder: (noteEditingContext) => [
                  PopupMenuItem(
                    height: 30,
                    padding: const EdgeInsets.fromLTRB(15, 0, 100, 0),
                    child: const Text('Delete'),
                    onTap: () {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        deleteThisNote();
                      });
                    },
                  ),
                ],
              ),
      ],
    );
  }
}
