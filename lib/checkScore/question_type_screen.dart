import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/models/hero/chapter.dart';
import 'package:mcq/models/hero/question_type.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/views/screens/hero/question_status/question_status_screen.dart';
import 'package:mcq/views/screens/hero/question_type/question_type_view_model.dart';
import 'package:mcq/views/screens/hero/series/series_screen.dart';

class QuestionTypeScreen extends StatefulWidget {
  final Chapter Function() chapter;

  const QuestionTypeScreen({super.key, required this.chapter});

  @override
  State<QuestionTypeScreen> createState() => _QuestionTypeScreenState();
}

class _QuestionTypeScreenState extends State<QuestionTypeScreen>
    with TickerProviderStateMixin {

  late final QuestionTypeViewModel vm;

  @override
  void initState() {
    vm = Get.put(QuestionTypeViewModel(chapter: widget.chapter));
    vm.initViewModel(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => vm.loading.value
          ? AbsorbPointer(
        absorbing: true,
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      )
          : Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(vm.chapter.name!),
              Expanded(child: Container()),
              PopupMenuButton<String>(
                icon: Image.asset('assets/images/languages.png', height: 20,),
                onSelected: (String newValue) {
                  vm.areQuestionsAvailableInLanguage(newValue).then((isAvailable) {
                    if (isAvailable) {
                      setState(() {
                        vm.updateLanguage(newValue);
                      });
                    } else {
                      Get.snackbar(
                        'No Questions Available',
                        'There are no questions available in $newValue.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  });
                },
                itemBuilder: (BuildContext context) {
                  return <String>['Hindi', 'English'].map((String value) {
                    return PopupMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList();
                },
              ),

            ],
          ),
          bottom: TabBar(
            controller: vm.tabController,
            tabs: vm.tabs,
            indicatorColor: Colors.white,
            isScrollable: true,
          ),
        ),
        endDrawer: QuestionStatusScreen(
          questionStatusViewModel: vm.questionStatusViewModel,
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: vm.tabController,
          children: vm.questionTypesList.asMap().entries.map((entry) {
            final index = entry.key;
            final QuestionType questionType = entry.value;
            return SeriesScreen(
              questionType: () => questionType,
              index: index,
              selectedIndex: vm.selectedIndex,
            );
          }).toList(),
        ),
      ),
    );
  }
}
