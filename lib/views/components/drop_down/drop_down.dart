import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/drop_down/dropdown_view_model.dart';
import 'package:mcq/views/components/dropdown/dropdown_window.dart';
import '../custom_text_field.dart';
import 'drop_down_content.dart';
import 'drop_down_utils.dart';

class DropDown extends StatefulWidget {
  const DropDown({super.key, required this.vm});

  final DropdownViewModel vm;

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      readOnly: true,
      labelText: widget.vm.title,
      controller: widget.vm.controller,
      suffixIcon: widget.vm.suffixIcon,
      onTap: () {
        widget.vm.setSelectedList();
        Get.bottomSheet(
          DropDownContent(vm: widget.vm),
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
        );
      },
    );
  }
}
