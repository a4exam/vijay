import 'dart:convert';

import 'package:get/get.dart';
import 'package:mcq/data/network/base_api_services.dart';
import 'package:mcq/data/network/network_api_services.dart';
import 'package:mcq/utils/app_url.dart';
import 'package:mcq/views/components/drop_down/drop_down_utils.dart';

class AuthRepository {
  final BaseApiServices _apiServices = Get.put(NetworkApiServices());

  /// login
  Future<dynamic> login({required request}) async {
    final response = await _apiServices.getPostApiResponse(
      url: AppUrl.LOGIN_URL,
      body: request,
    );
    return response;
  }

  /// SEND OTP
  Future<dynamic> sendOtp({dynamic body}) async {
    return await _apiServices.getPostApiResponse(
      url: AppUrl.SENT_EMAIL_OTP_URL,
      body: body,
    );
  }

  /// OTP VERIFICATION
  Future<dynamic> otpVerification({dynamic body}) async {
    return await _apiServices.getPostApiResponse(
      url: AppUrl.OTP_VERIFICATION,
      body: body,
    );
  }

  ///
  Future<List<DropdownListItem>> getExamPreparation() async {
    List<DropdownListItem> examPreparationList = [];
    final response =
        await _apiServices.getGetApiResponse(url: AppUrl.EXAM_BOARD_NAME);
    if (response['responseCode'] == 1) {
      List<dynamic> responseData = response['data'];
      for (var item in responseData) {
        examPreparationList.add(DropdownListItem(
          title: item['name'],
          id: item['id'].toString(),
          img: item['image'],
        ));
      }
    }
    return examPreparationList;
  }

  /// save user data for signup
  Future<dynamic> signUp({dynamic body}) async {
    return await _apiServices.getPostApiResponse(
      url: AppUrl.RESIGNATION_URL,
      body: body,
    );
  }

  /// forgotPassword
  Future<dynamic> forgotPassword({dynamic body}) async {
    return await _apiServices.getPostApiResponse(
      url: AppUrl.FORGOT_PASSWORD_URL,
      body: body,
    );
  }

  /// updatePassword
  Future<dynamic> updatePassword({dynamic body}) async {
    return await _apiServices.getPostApiResponse(
      url: AppUrl.UPDATE_PASSWORD_URL,
      body: body,
    );
  }
}
