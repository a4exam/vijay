import 'package:flutter/material.dart';
import '../custom_text_field.dart';
import 'dropdown_alert.dart';
import '../drop_down/drop_down_utils.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.labelText,
    this.title,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.validator,
    this.searchable=false,
    this.selectedLimit = 1,
    this.textFieldOption = false,
  });

  final List<String> items;
  final String? labelText;
  final String? title;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool searchable;
  final bool textFieldOption;
  final int selectedLimit;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String) onChanged;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  List<DropdownListItem> dataList=[];
  List<DropdownListItem> _selectedItems = [];

  @override
  void initState() {
    dataList = widget.items
        .map((item) => DropdownListItem(title: item, isSelected: false, id: ''))
        .toList();
    super.initState();
  }

  @override
  void didUpdateWidget(CustomDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    dataList = widget.items
        .map((item) => DropdownListItem(title: item, isSelected: false, id: ''))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      readOnly: true,
      labelText: widget.labelText!,
      controller: widget.controller,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
      validator: widget.validator,
      onTap: () async {
        final List<DropdownListItem> results = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return DropdownAlert(
              items: dataList,
              title: widget.title,
              searchable: widget.searchable,
              textFieldOption: widget.textFieldOption,
              selectedItems: _selectedItems,
              selectedLimit: widget.selectedLimit,
            );
          },
        );
        if (results != null) {
          setState(() {
            _selectedItems = results;
            widget.controller.text = _getSelectedItemsText();
            widget.onChanged(results.first.title.toString());
          });
        }
      },
    );
  }

  String _getSelectedItemsText() {
    return _selectedItems.map((item) => item.title).join(", ");
  }
}

