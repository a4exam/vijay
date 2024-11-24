import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/dropdown/dropdown_window.dart';
import '../custom_text_field.dart';
import '../drop_down/drop_down_content.dart';
import '../drop_down/drop_down_utils.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({
    super.key,
    required this.dataList,
    this.labelText,
    this.title,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.searchable = false,
    this.selectedLimit = 1,
    this.textFieldOption = false,
    required this.callBackData,
  });

  final List<DropdownListItem> dataList;
  final String? labelText;
  final String? title;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? searchable;
  final bool? textFieldOption;
  final int selectedLimit;
  final TextEditingController controller;
  final Function(List<DropdownListItem>) callBackData;

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      readOnly: true,
      labelText: widget.labelText,
      controller: widget.controller,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
      onTap: () {

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return DropdownWindow(
              dataList: widget.dataList,
              title: widget.title!,
              searchable: widget.searchable!,
              textFieldOption: widget.textFieldOption!,
              selectedLimit: widget.selectedLimit,
              callBackData: widget.callBackData,
              controller: widget.controller,
            );
          },
        );
      },
    );
  }
}
