import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:mcq/data/network/base_api_services.dart';
import 'package:mcq/data/network/network_api_services.dart';
import 'package:mcq/models/api_response_model.dart';
import 'package:mcq/utils/app_url.dart';

class ProfileRepository {
  final BaseApiServices _apiServices = Get.put(NetworkApiServices());

  Future<ApiResponseModel<dynamic>> updateEmail({
    dynamic body,
    String? token,
  }) async {
    final response = await _apiServices.getPostApiResponse(
      url: AppUrl.UPDATE_EMAIL_URL,
      token: token,
      body: body,
    );
    return ApiResponseModel<dynamic>.fromJsonWithDynamic(response);
  }

  Future<ApiResponseModel<dynamic>> updateMobile({
    dynamic body,
    String? token,
  }) async {
    final response = await _apiServices.getPostApiResponse(
      url: AppUrl.UPDATE_MOBILE_URL,
      token: token,
      body: body,
    );
    return ApiResponseModel<dynamic>.fromJsonWithDynamic(response);
  }

  Future<dynamic> updatePassword(dynamic body) async {
    return await _apiServices.getPostApiResponse(
      url: AppUrl.UPDATE_PASSWORD_URL,
      body: body,
    );
  }

  Future<dynamic> changeProfile({
    required String token,
    required File file,
  }) async {
    final response = await _apiServices.getPostMultipartApiResponse(
      url: AppUrl.PROFILE_IMAGE_URL,
      file: file,
      token: token,
      fileFieldName: 'images',
    );
    return response;
  }

  Future<dynamic> editProfile({
    required String token,
    required dynamic body,
  }) async {
    final response = await _apiServices.getPostApiResponse(
      url: AppUrl.EDIT_PROFILE_DETAILS_URL,
      token: token,
      body: body,
    );
    return response;
  }
}
