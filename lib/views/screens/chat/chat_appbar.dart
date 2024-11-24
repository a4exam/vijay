import 'package:flutter/material.dart';

class ChatAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppbar({
    Key? key,
    required this.isFromHome,
    required this.searchOnPressed,
  }) : super(key: key);

  final bool isFromHome;
  final Function() searchOnPressed;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      title: Container(
        child: Row(
          children: [
            Icon(Icons.menu),
            SizedBox(
              width: 10,
            ),
            Text(
              "Chat",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
