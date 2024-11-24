import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/models/exam_preparation/ExamPreparationListItem.dart';
import 'package:mcq/views/components/loading_overlay.dart';
import 'package:mcq/views/screens/profile/inner_screen/exam_preparation/ExamPreparationViewModel.dart';

class ExamPreparationScreen extends StatefulWidget {
  final ExamPreparationViewModel vm;

  const ExamPreparationScreen({
    super.key,
    required this.vm,
  });

  @override
  State<ExamPreparationScreen> createState() => _ExamPreparationScreenState();
}

class _ExamPreparationScreenState extends State<ExamPreparationScreen>
    with SingleTickerProviderStateMixin {
  late ExamPreparationViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = widget.vm;
  }

  @override
  Widget build(BuildContext context) {
    vm.setTabController(this);
    return LoadingOverView(
      loading: vm.loading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Exam Preparation'),
          bottom: TabBar(
            controller: vm.tabController,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: 'Board'),
              Tab(text: 'Category'),
            ],
          ),
        ),
        body: TabBarView(
          controller: vm.tabController,
          children: [
            Obx(
              () => tabItemView(
                title: "Exam board",
                data: vm.eNameList.value,
              ),
            ),
            Obx(
              () => tabItemView(
                title: "Exam category",
                data: vm.eCategoryList.value,
              ),
            ),
          ],
        ),
      ),
    );
  }

  tabItemView(
      {required String title, required List<ExamPreparationListItem> data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Get.height * .02),
          Text(title),
          SizedBox(height: Get.height * .02),
          SizedBox(
            height: Get.height * .745,
            child: ListView.builder(
                itemCount: data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final item = data[index];
                  return InkWell(
                    onTap: () {
                      vm.onPressedItem(item);
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: Get.height * .005),
                                Text(
                                  "${item.data!.length} Exam",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: Get.height * .005),
                                Obx(
                                  () => vm.getSelectedCount(item.selectedId.value) !=
                                          "0"
                                      ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.green.shade50,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 4),
                                          child: Text(
                                            "${vm.getSelectedCount(item.selectedId.value)} Selected item",
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                            leading: Icon(
                              Icons.access_alarm,
                              size: Get.width * .11,
                            ),
                            trailing:
                                const Icon(Icons.arrow_right_alt_outlined),
                          ),
                        ),
                        Container(
                          width: Get.width,
                          height: Get.height * .001,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
