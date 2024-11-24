import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/helpers/preferences_helper.dart';
import 'package:mcq/models/exam_preparation/ExamPreparationListItem.dart';
import 'package:mcq/repository/exam_preparation_repository.dart';
import 'package:mcq/views/components/drop_down/drop_down_content.dart';
import 'package:mcq/views/components/drop_down/drop_down_utils.dart';
import 'package:mcq/views/components/drop_down/dropdown_view_model.dart';

class ExamPreparationViewModel extends GetxController {
  final TextEditingController controller;
  ExamPreparationRepository examPreparationRepository =
      Get.put(ExamPreparationRepository());
  RxBool loading = false.obs;

  ExamPreparationViewModel(
      {required this.controller,
      required this.selectedName,
      required this.selectedId}) {
    init();
  }

  String selectedId = "";
  String selectedName = "";

  late String token;

  init() async {
    setLoading(true);
    token = await PreferenceHelper.getToken();
    final list = await examPreparationRepository.getExamPreparationListData();
    if (list.isNotEmpty ) {
      if(selectedId.isNotEmpty){
        for (int index = 0; index < list.length; index++) {
          final selectedItems = list[index].data?.where((element) => selectedId.split(",").contains(element.id)).toList();
          if (selectedItems != null) {
            list[index].selectedId.value = getSelectedId(selectedItems);
            list[index].selectedName = getSelectedName(selectedItems);
          }
        }
      }
      eNameList.value = list.where((e) => e.type == "board").toList();
      eCategoryList.value = list.where((e) => e.type == "category").toList();
    }
    setLoading(false);

  }

  String getSelectedId(List<DropdownListItem> a) {
    String id = "";
    for (var element in a) {
      id = id.isEmpty ? element.id : "$id,${element.id}";
    }
    return id;
  }
  String getSelectedName(List<DropdownListItem> a) {
    String title = "";
    for (var element in a) {
      title = title.isEmpty ? element.title : "$title,${element.title}";
    }
    return title;
  }

  void setLoading(val) => loading.value = val;

  TabController? tabController;

  final eNameList = Rx<List<ExamPreparationListItem>>([]),
      eCategoryList = Rx<List<ExamPreparationListItem>>([]);

  setTabController(TickerProvider tickerProvider) {
    tabController ??= TabController(length: 2, vsync: tickerProvider);
  }

  String getSelectedCount(String? id) {
    if (id == null || id == "") return "0";
    return id.split(',').length.toString();
  }

  onPressedItem(ExamPreparationListItem item) async {
    final vm = DropdownViewModel(
      suffixIcon: Icons.menu_book_outlined,
      dataList: item.data!,
      selectedLimit: item.data!.length,
      controller: controller,
      selectedId: selectedId,
      title: "Exam Preparation",
      height: 0.95,
      onChanged: (list, titles, ids) async {
        item.selectedId.value = ids;
        item.selectedName = titles;
        selectedId = "";
        selectedName = "";
        for (ExamPreparationListItem item in eNameList.value) {
          if (item.selectedName != null && item.selectedName != "") {
            selectedName = selectedName == ""
                ? item.selectedName!
                : "$selectedName,${item.selectedName}";
            selectedId = selectedId == ""
                ? item.selectedId.value
                : "$selectedId,${item.selectedId.value}";
          }
        }
        for (ExamPreparationListItem item in eCategoryList.value) {
          if (item.selectedName != null && item.selectedName != "") {
            selectedName = selectedName == ""
                ? item.selectedName!
                : "$selectedName,${item.selectedName}";
            selectedId = selectedId == ""
                ? item.selectedId.value
                : "$selectedId,${item.selectedId.value}";
          }
        }
        controller.text = selectedName.replaceAll(",", ", ");
      },
    );
    vm.setSelectedList();
    Get.bottomSheet(
      DropDownContent(vm: vm),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }
}
