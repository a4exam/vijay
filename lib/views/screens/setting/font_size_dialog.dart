import 'package:flutter/material.dart';
import 'package:mcq/views/components/dialog_box_wrapper.dart';

class FontSizeDialog extends StatefulWidget {
  final double initialFontSize;
  final Function(double) onFontSizeChanged;

  const FontSizeDialog({
    super.key,
    required this.initialFontSize,
    required this.onFontSizeChanged,
  });

  @override
  _FontSizeDialogState createState() => _FontSizeDialogState();
}

class _FontSizeDialogState extends State<FontSizeDialog> {
  late double selectedFontSize;

  @override
  void initState() {
    super.initState();
    selectedFontSize = widget.initialFontSize ?? 18.0;
  }

  @override
  Widget build(BuildContext context) {
    return DialogBoxWrapper(
      title: 'Font Size',
      content: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Select Font Size',
                style: TextStyle(fontSize: selectedFontSize),
              ),
            ),
            Slider(
              value: selectedFontSize,
              min: 10,
              max: 30,
              divisions: 4,
              onChanged: (double value) {
                setState(() {
                  selectedFontSize = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Apply'),
          onPressed: () {
            widget.onFontSizeChanged?.call(selectedFontSize);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

