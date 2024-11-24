import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/color.dart';

class OTPTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? error;
  final int otpLength;

  const OTPTextField({
    super.key,
    required this.controller,
    this.otpLength = 6,
    this.error,
  });

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _focusNodes =
        List<FocusNode>.generate(widget.otpLength, (index) => FocusNode());
    _controllers = List<TextEditingController>.generate(
      widget.otpLength,
      (index) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.otpLength; i++) {
      _focusNodes[i].dispose();
      _controllers[i].dispose();
    }
    super.dispose();
  }

  void _onTextChanged(String value, int index) {
    String controllerText = "";
    for (var controller in _controllers) {
      controllerText += controller.text;
    }
    widget.controller.text = controllerText;
    if (value.isNotEmpty) {
      setState(() {
        _currentIndex = index + 1;
      });
      if (_currentIndex < widget.otpLength) {
        FocusScope.of(context).requestFocus(_focusNodes[_currentIndex]);
      } else {
        FocusScope.of(context).unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              widget.otpLength,
              (index) => Container(
                margin: const EdgeInsets.only(right: 16),
                width: 40.0,
                height: 40.0,
                child: TextFormField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    _onTextChanged(value, index);
                  },
                  cursorColor:
                      widget.error == null ? AppColors.primaryColor : Colors.red,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.error == null
                              ? AppColors.primaryColor
                              : Colors.red),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.error == null ? Colors.grey : Colors.red),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (widget.error != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10),
            child: Text(
              widget.error!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          )
      ],
    );
  }
}
