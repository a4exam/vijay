import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcq/models/help/faq_list.dart';
import 'package:mcq/models/comman/user_profile_data.dart';
import 'package:mcq/repository/help_repository.dart';

class HelpViewModel extends GetxController {
  HelpRepository? helpRepository;
  UserProfileData? userData;
  final faqListItem = Rx<FaqListItem?>(null);

  // call back var
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController mobileNoController;
  late TextEditingController issuesController;
  late TextEditingController aboutProblemController;
  RxBool loading = false.obs;

  void setLoading(val) => loading.value = val;

  RxBool visibilityOfLanguageBtn = true.obs;

  void setVisibilityOfLanguageBtn() =>
      visibilityOfLanguageBtn.value = tabController?.index == 0 ? true : false;

  final isLanguageEn = true.obs;

  void setLanguage() => isLanguageEn.value = !isLanguageEn.value;

  TabController? tabController;

  setTabController(TickerProvider tickerProvider) {
    if (tabController == null) {
      tabController = TabController(length: 2, vsync: tickerProvider);
      tabController?.addListener(setVisibilityOfLanguageBtn);
    }
  }

  HelpViewModel({this.userData}) {
    helpRepository = HelpRepository();
    final body = {"subjectName": "home"};
    getFaq(body: body);
    nameController = TextEditingController(text: userData?.fullName);
    emailController = TextEditingController(text: userData?.email);
    mobileNoController = TextEditingController(text: userData?.mobileNo);
    issuesController = TextEditingController();
    aboutProblemController = TextEditingController();
  }

  Future<void> handelCallBackSubmitBtn() async {
    loading.value = true;
    final body = {
      'name': nameController.text,
      'email': emailController.text,
      'mobileNo': mobileNoController.text,
      'issues': issuesController.text,
      'aboutProblem': aboutProblemController.text,
    };
    var req = await helpRepository?.sendBackCall(body);

    if (req.msgtype == "success") {
      issuesController.text = "";
      aboutProblemController.text = "";
      Get.snackbar(
        "Required a back call",
        req.msg,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    } else {
      Get.snackbar(
        "Required a back call",
        req.msg,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
    loading.value = false;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // setState(() {
      //   // _image = File(pickedImage.path);
      // });
    }
  }

  Future<void> getFaq({dynamic body}) async {
    final response = await helpRepository?.getFaq(body: body);
    faqListItem.value = response?.data;
  }
}
