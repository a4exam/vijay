import 'package:get/get.dart';
import 'package:mcq/helpers/preferences_helper.dart';
import 'package:mcq/models/comman/IdName.dart';
import 'package:mcq/models/hero/chapter.dart';
import 'package:mcq/models/hero/question.dart';
import 'package:mcq/models/hero/question_type.dart';
import 'package:mcq/repository/hero_repository.dart';
import 'package:mcq/views/screens/hero/question_type/question_type_screen.dart';

import '../../../../models/hero/alldescriptionresponse.dart';

class HeroViewModel extends GetxController {
  final heroRepository = Get.put(HeroRepository());
  RxBool loading = false.obs;
  RxList<IdName> subjects = <IdName>[].obs;
  RxList<IdName> books = <IdName>[].obs;
  RxList<AllDescriptionData> allDescription = <AllDescriptionData>[].obs;
  //RxList<Question> question = <Question>[].obs;
  String selectedMenuItem = 'Default';

  // RxList<IdName> selectedSubject = <IdName>[].obs;
  Rx<IdName?> selectedSubject = Rx<IdName?>(null);

  late String token;

  HeroViewModel() {
    init();
  }

  init() async {
    token = await PreferenceHelper.getToken();
    await getSubject();
    selectedSubject.value = subjects.first;
    getBook(selectedSubject.value!.id);

  }

  getSubject() async {
    loading.value = true;
    subjects.value = await heroRepository.getSubject(
      catId: "1",
      token: token,
    );
    loading.value = false;
  }

  Future<List<Chapter>> getChapters(String bookId) async {
    loading.value = true;
    final chapters = await heroRepository.getChapters(
      bookId: bookId,
      token: token,
    );
    loading.value = false;
    return chapters;
  }

  getBook(String? subId) async {
    loading.value = true;
    books.value = await heroRepository.getBooks(
      subId: subId,
      token: token,
    );
    loading.value = false;
  }

  setLoading(val) => loading.value = val;

  setSelectedMenuItem(String menuItem) {
    selectedMenuItem = menuItem;
  }

  void onPressedSubject({
    required IdName subject,
    required bool isSelected,
  }) {
    if (isSelected && selectedSubject.value != subject) {
      selectedSubject.value = subject;
      getBook(subject.id);
    }
  }

  void onPressedChapter(Chapter chapter) {
    Get.to(
      QuestionTypeScreen(chapter: () => chapter),
      transition: Transition.rightToLeft,
    );
  }
}
