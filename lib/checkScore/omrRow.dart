import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/screens/checkScrore/checkscore_view_model.dart';

class OMRRow extends StatefulWidget {
  final int questionNumber;
  final int? selectedOption;
  final Function(int) onSelectOption;

  const OMRRow({
    required this.questionNumber,
    required this.onSelectOption,
    this.selectedOption,
    super.key,
  });

  @override
  _OMRRowState createState() => _OMRRowState();
}

class _OMRRowState extends State<OMRRow> {
  int? selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            widget.questionNumber.toString().padLeft(3, '0'),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(width: 20),
          for (int i = 1; i <= 4; i++) // Replace '4' with the correct number of options
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedOption = i;
                });
                widget.onSelectOption(i);
              },
              child: OMRBubble(
                optionNumber: i,
                isSelected: selectedOption == i,
              ),
            ),
        ],
      ),
    );
  }
}

class OMRBubble extends StatelessWidget {
  final int optionNumber;
  final bool isSelected;

  const OMRBubble({
    required this.optionNumber,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.pink : Colors.white,
        border: Border.all(color: Colors.pink, width: 2),
      ),
      child: Center(
        child: Text(
          optionNumber.toString(),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.pink,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

