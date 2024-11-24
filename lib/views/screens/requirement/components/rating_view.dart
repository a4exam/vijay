import 'package:flutter/material.dart';
import 'package:mcq/views/screens/requirement/requirement_utils.dart';

class RatingView extends StatelessWidget {
  final RatingListItem item;
  final Function(String) onPressed;
  final bool isSelected;

  const RatingView(
      {super.key,
      required this.item,
      required this.onPressed,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onPressed(item.rateValue);
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.grey),
            ),
            child: Text(
              item.emoji,
              style: const TextStyle(fontSize: 30),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(item.title),
      ],
    );
    ;
  }
}
