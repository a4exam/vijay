import 'package:flutter/material.dart';
import 'package:mcq/themes/color.dart';

class UserActionButton extends StatelessWidget {
  final IconData iconData;
  final MaterialColor color;
  final String value;
  final VoidCallback onTap;

  const UserActionButton({
    super.key,
    required this.iconData,
    required this.color,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffE9F6FB),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              iconData,
              color: color,
            ),
            const SizedBox(width: 5),
            Text(
              value,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
