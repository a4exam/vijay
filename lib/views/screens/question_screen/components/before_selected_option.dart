import 'package:flutter/material.dart';
import 'package:mcq/views/screens/question_screen/question_utils.dart';

class BeforeSelectedOption extends StatefulWidget {
  final String title;
  final SelectedOption selectedOption;
  final Function(String) onChange;

  const BeforeSelectedOption({
    super.key,
    required this.title,
    required this.selectedOption,
    required this.onChange,
  });

  @override
  _BeforeSelectedOptionState createState() => _BeforeSelectedOptionState();
}

class _BeforeSelectedOptionState extends State<BeforeSelectedOption> {
  bool eliminated = false;

  @override
  Widget build(BuildContext context) {
    eliminated = widget.selectedOption.isSelected ? false : eliminated;
    final radioColor = eliminated ? Colors.grey : Colors.white;
    return RadioListTile(
      value: widget.title,
      title: Text(
        widget.title,
        style: const TextStyle(fontSize: 16),
      ),
      groupValue: widget.selectedOption.selectedOptionTitle,
      onChanged: (newValue) {
        if (!eliminated) {
          widget.onChange(newValue!);
        }
      },
      secondary: IconButton(
        icon: const Icon(
          Icons.cancel_rounded,
          color: Colors.red,
        ),
        onPressed: () {
          if (!widget.selectedOption.isSelected) {
            setState(() {
              eliminated = !eliminated;
            });
          }
        },
      ),
      selected: false,
      tileColor: radioColor,
    );
  }
}
