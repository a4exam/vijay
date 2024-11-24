import 'package:flutter/material.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/utils/utils.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.errorText,
    this.initialValue,
    this.maxLines,
    this.minLines,
    this.controller,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconOnPressed,
    this.validator,
    this.readOnly = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.onTap,
  });

  final String? hintText;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;
  final String? labelText;
  final String? initialValue;
  final String? errorText;
  final bool? readOnly;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? enabled;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final Function()? suffixIconOnPressed;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      initialValue: initialValue,
      maxLines: maxLines,
      focusNode: focusNode,
      minLines: minLines,
      readOnly: readOnly ?? false,
      onTap: onTap,
      validator: validator,
      enabled: enabled,
      decoration: InputDecoration(
        focusColor: AppColors.primaryColor,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: suffixIconOnPressed,
              )
            : null,
        labelText: labelText,
        hintText: hintText,
        errorText: errorText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: AppBorderRadius.textFormFieldBorderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: AppBorderRadius.textFormFieldBorderRadius,
        ),
        border: OutlineInputBorder(
          borderRadius: AppBorderRadius.textFormFieldBorderRadius,
        ),
      ),
    );
  }
}
