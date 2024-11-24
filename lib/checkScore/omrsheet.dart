import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/models/checkScrore/examsiftsetingResponse.dart';
import 'package:mcq/themes/color.dart';
import '../views/screens/checkScrore/checkscore_view_model.dart';
import 'omrAnswerSheet.dart';

class OmrSheet extends StatefulWidget {
  const OmrSheet({super.key});

  @override
  _OmrSheetState createState() => _OmrSheetState();
}
class _OmrSheetState extends State<OmrSheet>{


  final CheckScoreViewModel vm = Get.put(CheckScoreViewModel());
  @override
  void initState() {
    super.initState();
    vm.init(); // Initialize the ViewModel
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'OMR Answer Sheet',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Obx(() {
            final details = vm.settingDetails.value;
            if (details == null ||
                details.shiftSettingDetails == null ||
                details.shiftSettingDetails!.sectiondetails == null ||
                details.shiftSettingDetails!.sectiondetails!.isEmpty ||
                vm.tabController == null) {
              return const SizedBox.shrink(); // Return empty widget if no sections or TabController not initialized
            }

            return TabBar(
              controller: vm.tabController,
              isScrollable: true,
              tabs: details.shiftSettingDetails!.sectiondetails!.map((section) {
                return Tab(
                  text: section.name ?? 'Section',
                );
              }).toList(),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.white,
              labelStyle: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              indicatorWeight: 2.0,
            );
          }),
        ),
      ),
      body: Obx(() {
        final details = vm.settingDetails.value;
        if (details == null ||
            details.shiftSettingDetails == null ||
            details.shiftSettingDetails!.sectiondetails == null ||
            details.shiftSettingDetails!.sectiondetails!.isEmpty ||
            vm.tabController == null) {
          return const Center(child: CircularProgressIndicator()); // Show loading if no sections or TabController not initialized
        }

        return TabBarView(
          controller: vm.tabController,
          children: details.shiftSettingDetails!.sectiondetails!.map((section) {
            return OMRAnswerSheet(section: section);
          }).toList(),
        );
      }),
    );
  }
}


