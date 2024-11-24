import 'package:country_state_city/models/city.dart';
import 'package:country_state_city/utils/city_utils.dart';
import 'package:country_state_city/utils/state_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/models/comman/user_profile_data.dart';
import 'package:mcq/views/components/drop_down/drop_down_utils.dart';

class UpdateAddressViewModel extends GetxController {
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final districtController = TextEditingController();
  final townVillageController = TextEditingController();
  final pinCodeController = TextEditingController();
  final stateList = Rx<List<DropdownListItem>>([]);
  final cityList = Rx<List<DropdownListItem>>([]);
  final Function(
    String newCountry,
    String newState,
    String newDistrict,
    String newTown,
    String newPinCode,
  ) onPressedSubmitButton;
  RxBool loading = false.obs;

  UpdateAddressViewModel({
    required String country,
    required String state,
    required String district,
    required String town,
    required String pinCode,
    required this.onPressedSubmitButton,
  }) {
    countryController.text = country;
    stateController.text = state;
    districtController.text = district;
    townVillageController.text = town;
    pinCodeController.text = pinCode;
    getStateList();
    getCityList(stateName: stateController.text);
  }

  getStateList() async {
    final states = await getStatesOfCountry('IN');
    stateList.value = states
        .map((e) => DropdownListItem(title: e.name, id: e.isoCode))
        .toList();
  }

  getCityList({String? stateCode, String? stateName}) async {
    List<City> cities;
    String? isoCode;
    if (stateName != null) {
      final states = await getStatesOfCountry('IN');
      isoCode =
          states.where((element) => element.name == stateName).first.isoCode;
    }
    if (stateCode != null) {
      cities = await getStateCities('IN', stateCode);
    } else if (isoCode != null) {
      cities = await getStateCities('IN', isoCode);
    } else {
      cities = await getAllCities();
    }
    cityList.value = cities
        .map((e) =>
            DropdownListItem(title: e.name, id: "${e.latitude}#${e.longitude}"))
        .toList();
  }

  onChangedCountry(List<DropdownListItem> list, String titles, String ids) {
    if (list.isNotEmpty) {
      getStateList();
    } else {
      stateList.value = [];
    }
  }

  onChangedState(List<DropdownListItem> list, String titles, String ids) {
    if (list.isNotEmpty) {
      getCityList(stateCode: list.first.id);
    } else {
      cityList.value = [];
    }
  }

  onChangedCity(List<DropdownListItem> list, String titles, String ids) {
    if (list.isNotEmpty) {
      pinCodeController.text = "";
      townVillageController.text = "";
    } else {
      pinCodeController.text = "";
      townVillageController.text = "";
    }
  }

  onPressedSubmitBtn() {
    if (countryController.text.isEmpty ||
        stateController.text.isEmpty ||
        districtController.text.isEmpty ||
        townVillageController.text.isEmpty ||
        pinCodeController.text.isEmpty) {
      Get.snackbar(
        "Invailed field",
        "Should be fill all values",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return;
    }
    onPressedSubmitButton(
      countryController.text,
      stateController.text,
      districtController.text,
      townVillageController.text,
      pinCodeController.text,
    );
    Get.back();
  }
}
