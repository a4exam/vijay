import 'package:get/get.dart';
import 'package:mcq/helpers/preferences_helper.dart';
import 'package:mcq/models/comman/user_profile_data.dart';
import 'package:mcq/repository/home_repository.dart';
import 'package:mcq/repository/profile_repository.dart';

class UserdataViewModel extends GetxController {

  final _repository = Get.put(HomeRepository());
  Rx<UserProfileData?> userData = Rx<UserProfileData?>(null);

  getUserdata() async {
    final token = await PreferenceHelper.getToken();
    final data = await _repository.getProfile(token);
    if(data["responseCode"]==1){
      userData.value = UserProfileData.fromJson(data["data"]);
    }
  }

}