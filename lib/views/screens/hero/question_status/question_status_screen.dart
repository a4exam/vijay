import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/questions_status_flag.dart';
import 'package:mcq/views/screens/hero/question_status/components/top_header.dart';
import 'package:mcq/views/screens/hero/question_status/question_status_view_model.dart';
import 'package:sizer/sizer.dart';
import 'components/smartMode.dart';
import 'components/ultimate_mode.dart';

class QuestionStatusScreen extends StatefulWidget {
  final QuestionStatusViewModel questionStatusViewModel;

  const QuestionStatusScreen({
    super.key,
    required this.questionStatusViewModel,
  });

  @override
  State<QuestionStatusScreen> createState() => _QuestionStatusScreenState();
}

class _QuestionStatusScreenState extends State<QuestionStatusScreen>
    with AutomaticKeepAliveClientMixin<QuestionStatusScreen> {
  late final QuestionStatusViewModel vm;

  @override
  void initState() {
    vm = widget.questionStatusViewModel;
    super.initState();
  }

  List<String> alphabetList = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Drawer(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              color: AppColors.primaryColor,
              child: SafeArea(
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Obx(
                      () => Text(
                        vm.isUltimateMode.value
                            ? "Ultimate mode"
                            : "Smart mode",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Obx(
                      () => Switch(
                        onChanged: vm.onChangedUltimateMode,
                        activeColor: Colors.white,
                        value: vm.isUltimateMode.value,
                      ),
                    ),
                    IconButton(
                      onPressed: vm.onPressedListMode,
                      icon: Obx(
                        () => Icon(
                          vm.isListMode.value
                              ? Icons.view_module
                              : Icons.view_agenda,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: ListView(
            children: [
              const TopHeader(),
              const Divider(color: Colors.grey),
              Obx(
                () => vm.isUltimateMode.value
                    ? ultimateMode(
                        context: context,
                        isListMode: vm.isListMode.value,
                        alphabetList: alphabetList,
                      )
                    : smartMode(
                        context: context,
                        isListMode: vm.isListMode.value,
                        alphabetList: alphabetList,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
