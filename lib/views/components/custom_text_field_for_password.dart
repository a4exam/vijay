import 'package:flutter/material.dart';
import 'package:mcq/utils/utils.dart';

class CustomTextFieldForPassword extends StatefulWidget {
  const CustomTextFieldForPassword({
    super.key,
    this.hintText,
    this.labelText,
    required this.controller,
    this.prefixIcon,
    this.suffixIconOnPressed,
    this.obscureText,
    this.validator,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
  });

  final String? hintText;
  final String? labelText;
  final bool? obscureText;
  final IconData? prefixIcon;
  final bool? enabled;
  final String? Function(String?)? validator;
  final Function()? suffixIconOnPressed;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  @override
  State<CustomTextFieldForPassword> createState() =>
      _CustomTextFieldForPasswordState();
}

class _CustomTextFieldForPasswordState
    extends State<CustomTextFieldForPassword> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          child: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: AppBorderRadius.textFormFieldBorderRadius,
        ),
      ),
      validator: widget.validator,
      obscureText: !_isPasswordVisible,
    );

  }
}
