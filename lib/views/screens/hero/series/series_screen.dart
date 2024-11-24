import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/models/hero/question_type.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/custom_spacer.dart';
import 'package:mcq/views/screens/hero/question/question_screen.dart';
import 'package:mcq/views/screens/hero/question/question_view_model.dart';
import 'package:mcq/views/screens/hero/question_type/components/circle_text.dart';
import 'package:mcq/views/screens/hero/series/series_view_model.dart';

class SeriesScreen extends StatefulWidget {
  const SeriesScreen({
    super.key,
    required this.questionType,
    required this.selectedIndex,
    required this.index,
  });

  final QuestionType Function() questionType;
  final RxInt selectedIndex;
  final int index;

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen>
    with AutomaticKeepAliveClientMixin<SeriesScreen>, WidgetsBindingObserver {
  late SeriesViewModel vm;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {

    super.initState();
    vm = SeriesViewModel(questionType: widget.questionType());
    WidgetsBinding.instance.addObserver(this);
    widget.selectedIndex.listen((selectedIndex) {
      vm.hasStartTime.value = widget.index == selectedIndex;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    vm.hasStartTime.value = state == AppLifecycleState.resumed;
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // hSpacer(20),
            // questionFlag(vm.questionType.series!),
            QuestionScreen(
              vm: QuestionViewModel(
                hasStartTime: vm.hasStartTime,
                typeId: vm.questionType.typeId.toString(),
                seriesCount: vm.questionType.series!.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  questionFlag(List<Series> series) {
    return Row(
      children: [
        Obx(() => circleText(vm.currentSeries.value)),
        wSpacer(10),
        line(),
        Expanded(
          child: SizedBox(
            height: 35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: series.first.seriesData!.length!,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = series.first.seriesData![index];
                return circleText(item.questionFlag);
              },
            ),
          ),
        )
      ],
    );
  }

  line() => Container(color: Colors.grey, width: 1, height: 30);
}
