import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'drop_down_utils.dart';

class DropdownViewModel extends GetxController {
  final List<DropdownListItem> dataList;
  final String title;
  final bool isShowImage;
  final double? height;
  final IconData? suffixIcon;
  final int selectedLimit;
  String? selectedId;
  final TextEditingController controller;
  final filterList = RxList<DropdownListItem>([]);
  final selectedList = RxList<DropdownListItem>([]);
  final Function(
    List<DropdownListItem> list,
    String title,
    String id,
  )? onChanged;

  DropdownViewModel({
    required this.dataList,
    this.selectedId,
    required this.title,
    this.isShowImage = false,
    this.suffixIcon,
    this.height,
    required this.controller,
    this.onChanged,
    this.selectedLimit = 1,
  }) {
    setSelectedList();
  }

  setSelectedList() {
    filterList.value = dataList;
    if (selectedId != null) {
      final tempSelectedList = selectedId!.split(",");
      selectedList.clear();
      selectedList.value = dataList
          .where((element) => tempSelectedList.contains(element.id))
          .toList();
    } else {
      final tempSelectedList = controller.text.split(", ");
      selectedList.clear();
      selectedList.value = dataList
          .where((element) => tempSelectedList.contains(element.title))
          .toList();
    }
  }

  onPressedItem(DropdownListItem item, bool isChecked) {
    /// for single selection
    if (selectedLimit == 1) {
      selectedList.clear();
      if (isChecked) {
        selectedList.add(item);
      }
    }

    /// for multi selection
    else {
      if (isChecked && selectedList.length >= selectedLimit) {
        Get.snackbar(
          "Failed",
          "you can select only $selectedLimit",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      } else if (isChecked) {
        selectedList.add(item);
      } else {
        selectedList.remove(item);
      }
    }
  }

  onPressedSubmitBtn() {
    if (selectedList.isNotEmpty) {
      /// for single selection
      if (selectedLimit == 1) {
        controller.text = selectedList.first.title;
      }

      /// for multi selection
      else {
        controller.text = getSelectedText();
      }
    } else {
      controller.text = "";
    }
    if (onChanged != null) {
      selectedId = getSelectedId();
      onChanged!(
        selectedList,
        getSelectedTitle(),
        selectedId!,
      );
    }
    Get.back();
  }

  String getSelectedText() {
    String val = "";
    for (var element in selectedList) {
      val = val.isEmpty ? element.title : "$val, ${element.title}";
    }
    return val;
  }

  String getSelectedTitle() {
    String val = "";
    for (var element in selectedList) {
      val = val.isEmpty ? element.title : "$val,${element.title}";
    }
    return val;
  }

  String getSelectedId() {
    String id = "";
    for (var element in selectedList) {
      id = id.isEmpty ? element.id : "$id,${element.id}";
    }
    return id;
  }

  void onChangeSearchText(String value) {
    filterList.value = value.isEmpty
        ? dataList
        : dataList
            .where((item) =>
                item.title.toLowerCase().contains(value.toLowerCase()))
            .toList();
  }
}
