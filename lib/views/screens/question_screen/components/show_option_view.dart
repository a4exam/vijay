import 'package:flutter/material.dart';
import 'package:mcq/views/screens/question_screen/question_utils.dart';
import 'package:mcq/views/screens/question_screen/components/after_selected_option.dart';
import 'package:mcq/views/screens/question_screen/components/before_selected_option.dart';

class ShowOption extends StatefulWidget {
  final List<String> options;
  final String rightOption;
  final Function(String) onTap;
  final SelectedOption selectedOption;

  const ShowOption({
    super.key,
    required this.options,
    required this.onTap,
    required this.rightOption,
    required this.selectedOption,
  });

  @override
  State<ShowOption> createState() => _ShowOptionState();
}

class _ShowOptionState extends State<ShowOption> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.options.length,
      itemBuilder: (context, index) {
        var option = widget.options[index];

        return widget.selectedOption.isSelected
            ? AfterSelectedOption(
          option: option,
          optionNumber: (index + 1).toString(),
          rightOption: widget.rightOption,
          selectedOption: widget.selectedOption.selectedOptionTitle,
        )
            : BeforeSelectedOption(
          title: option,
          selectedOption: widget.selectedOption,
          onChange: (String newValue) {
            setState(() {
              widget.onTap(newValue);
              widget.selectedOption.selectedOptionTitle = newValue;
            });
          },
        );
      },
    );
  }
}
