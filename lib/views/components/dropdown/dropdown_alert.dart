import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../view_models/dark_theme_provider.dart';
import '../custom_button.dart';
import '../drop_down/drop_down_utils.dart';

class DropdownAlert extends StatefulWidget {
  final List<DropdownListItem> items;
  final String? title;
  final bool? searchable;
  final int? selectedLimit;
  final List<DropdownListItem> selectedItems;
  final bool? textFieldOption;

  const DropdownAlert({
    super.key,
    required this.items,
    this.title,
    required this.selectedItems,
    this.selectedLimit = 1,
    this.searchable = false,
    this.textFieldOption = false,
  });

  @override
  State<StatefulWidget> createState() => _DropdownAlertState();
}

class _DropdownAlertState extends State<DropdownAlert> {
  TextEditingController otherController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  List<DropdownListItem> filteredItems = [];
  bool isOtherSelected = false;
  int selectedCount = 0;
  late FocusNode textFieldFocus;
  late FocusNode searchFocus;

  @override
  void initState() {
    super.initState();
    textFieldFocus = FocusNode();
    searchFocus = FocusNode();
    filteredItems.addAll(widget.items);
    otherController.text = '';
    selectedCount = widget.selectedItems.length;

    for (var element in widget.items) {
      element.isSelected = widget.selectedItems.contains(element);
    }

    for (DropdownListItem value in widget.selectedItems) {
      if (!widget.items.contains(value)) {
        otherController.text = value.title;
        isOtherSelected = true;
        widget.items.last.isSelected = true;
      }
    }
  }



  @override
  void dispose() {
    textFieldFocus.dispose();
    searchFocus.dispose();
    super.dispose();
  }


  void _scrollTillEnd(int index, bool isChecked) {
    if(filteredItems[index].title=="Other" && isChecked){
      Timer(const Duration(milliseconds: 500), () {
        setState(() {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
        });
      });
    }

  }

  void filterItems(String query) {
    if (query.isNotEmpty) {
      setState(() {
        filteredItems = widget.items
            .where((item) =>
                item.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        filteredItems = widget.items;
      });
    }
  }

  void _itemChange(int index, bool isChecked) {
    setState(() {
      searchFocus.unfocus();
    });
    _scrollTillEnd(index, isChecked);
    if (widget.selectedLimit == 1) {
      setState(() {
        for (var i = 0; i < filteredItems.length; i++) {
          filteredItems[i].isSelected = i == index && isChecked;
        }
      });
    } else {
      if (isChecked && selectedCount >= widget.selectedLimit!) {
        return;
      }
      setState(() {
        filteredItems[index].isSelected = isChecked;
        selectedCount += isChecked ? 1 : -1;
        if (filteredItems[index].title == 'Other') {
          isOtherSelected = isChecked;
          otherController.text = isChecked ? "Other" : '';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var darkMode = Provider.of<DarkThemeProvider>(context).darkTheme;
    var foregroundColor = darkMode ? Colors.white : Colors.black;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      title: AppBar(
        title: Text(widget.title!, style: TextStyle(color: foregroundColor)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: foregroundColor,
      ),
      content: Container(
        constraints: const BoxConstraints(maxHeight: 400),
        width: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.searchable!)
              TextFormField(
                onChanged: filterItems,
                focusNode: searchFocus,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search",
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            Flexible(
              child: ListView.builder(
                itemCount: filteredItems.length,
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  if (widget.textFieldOption! &&
                      item.title == "Other" &&
                      item.isSelected) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16, right: 12.0),
                      child: TextFormField(
                        controller: otherController,
                        focusNode: textFieldFocus,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: item.title,
                          suffixIcon: Checkbox(
                            value: item.isSelected,
                            onChanged: (isChecked) {
                              _itemChange(index, isChecked!);
                            },
                          ),
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      CheckboxListTile(
                        value: item.isSelected,
                        title: Text(item.title),
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: (isChecked) {
                          _itemChange(index, isChecked!);
                        },
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
            CustomButton(
              width: 100.w,
              onPressed: () {
                final results = widget.items
                    .where((element) => element.isSelected)
                    .map((element) => element.title == "Other"
                        ? DropdownListItem(
                            title: otherController.text,
                            isSelected: true, id: '',
                          )
                        : element)
                    .toList();
                Navigator.pop(context, results);
              },
              title: 'Submit',
            )
          ],
        ),
      ),
    );
  }
}
