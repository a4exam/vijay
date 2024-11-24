import 'package:get/get.dart';
import 'package:mcq/data/network/base_api_services.dart';
import 'package:mcq/data/network/network_api_services.dart';
import 'package:mcq/models/api_response_model.dart';
import 'package:mcq/utils/app_url.dart';

class HomeRepository {
  final BaseApiServices _apiServices = Get.put(NetworkApiServices());

  Future<ApiResponseModel<dynamic>> sendRequirement(dynamic body) async {
    final response = await _apiServices.getPostApiResponse(
      url: AppUrl.REQUIREMENT_URL,
      body: body,
    );
    return ApiResponseModel<dynamic>.fromJsonWithDynamic(response);
  }

  Future<dynamic> getSubscription(dynamic body) async {
    return await _apiServices.getPostApiResponse(
      url: AppUrl.SUBSCRIPTION_URL,
      body: body,
    );
  }

  Future<dynamic> getProfile(String token) async {
    return await _apiServices.getGetApiResponse(
      url: AppUrl.GET_PROFILE_URL,
      token: token,
    );
  }
}
