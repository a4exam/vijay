
import 'package:get/get.dart';
import 'package:mcq/models/hero/question_type.dart';

class SeriesViewModel extends GetxController {
  final QuestionType questionType;

  SeriesViewModel({required this.questionType}) {
    currentSeries.value = questionType.series!.first.seriesName!;
  }

  RxString currentSeries = ''.obs;
  RxBool hasStartTime = false.obs;
  int currentSeriesIndex = 0;

  onPressed() {
    currentSeriesIndex++;
    currentSeries.value = questionType.series![currentSeriesIndex].seriesName!;
  }

}
