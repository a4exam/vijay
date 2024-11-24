import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../view_models/dark_theme_provider.dart';
import '../custom_button.dart';
import '../drop_down/drop_down_utils.dart';

class DropdownWindow extends StatefulWidget {
  final List<DropdownListItem> dataList;
  final String title;
  final bool searchable;
  final int selectedLimit;
  final bool textFieldOption;
  final TextEditingController controller;
  final Function(List<DropdownListItem>) callBackData;

  const DropdownWindow({
    super.key,
    required this.dataList,
    required this.title,
    required this.controller,
    this.selectedLimit = 1,
    this.searchable = false,
    this.textFieldOption = false,
    required this.callBackData,
  });

  @override
  State<StatefulWidget> createState() => _DropdownWindowState();
}

class _DropdownWindowState extends State<DropdownWindow> {
  late TextEditingController otherController;
  late ScrollController _scrollController;
  late List<DropdownListItem> filterList;
  late bool isOtherSelected;
  late int selectedCount;
  late FocusNode textFieldFocus;
  late FocusNode searchFocus;
  late List<DropdownListItem> dataList;
  late String otherText;

  @override
  void initState() {
    super.initState();
    otherController = TextEditingController();
    _scrollController = ScrollController();
    textFieldFocus = FocusNode();
    searchFocus = FocusNode();
    otherController.text = '';
    isOtherSelected = false;
    initData();
    filterList = dataList;
  }

  initData() {
    final selectList = widget.controller.text.split(", ");
    selectedCount = selectList.length;
    dataList = widget.dataList
        .map((item) => DropdownListItem(
            title: item.title,
            id: item.id,
            isSelected: selectList.contains(item.title)))
        .toList();
    if(selectList.isNotEmpty || !widget.textFieldOption){
      return;
    }
    for (var data in selectList) {
      if (data == "Other") {
        otherController.text = data;
        dataList.last.isSelected = true;
        isOtherSelected = true;
        break;
      }
      bool contain = false;
      for (var element in dataList) {
        if (element.title == data) {
          contain = true;
          break;
        }
      }
      if (!contain) {
        otherController.text = data;
        dataList.last.isSelected = true;
        isOtherSelected = true;
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
    if (filterList[index].title == "Other" && isChecked) {
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
        filterList = dataList
            .where((item) =>
                item.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        filterList = dataList;
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
        for (var data in dataList) {
          data.isSelected = false;
        }
        filterList[index].isSelected = isChecked;
      });
    } else {
      if (isChecked && selectedCount >= widget.selectedLimit) {
        return;
      }
      setState(() {
        filterList[index].isSelected = isChecked;
        selectedCount += isChecked ? 1 : -1;
        if (filterList[index].title == 'Other') {
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
        title: Text(widget.title, style: TextStyle(color: foregroundColor)),
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
            if (widget.searchable)
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
                itemCount: filterList.length,
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final item = filterList[index];
                  if (widget.textFieldOption &&
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
                final results = dataList
                    .where((element) => element.isSelected)
                    .map((element) => element.title == "Other"
                        ? DropdownListItem(
                            title: otherController.text,
                            id: element.id,
                            isSelected: true,
                          )
                        : element)
                    .toList();
                widget.controller.text =
                    results.map((item) => item.title).join(", ");
                if (widget.callBackData != null) {
                  widget.callBackData(results);
                }
                Navigator.pop(context);
              },
              title: 'Submit',
            )
          ],
        ),
      ),
    );
  }
}
