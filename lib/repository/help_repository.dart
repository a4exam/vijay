import 'package:get/get.dart';
import 'package:mcq/data/network/base_api_services.dart';
import 'package:mcq/data/network/network_api_services.dart';
import 'package:mcq/models/api_response_model.dart';
import 'package:mcq/models/help/faq_list.dart';
import 'package:mcq/utils/app_url.dart';

class HelpRepository {
  final BaseApiServices _apiServices = Get.put(NetworkApiServices());

  Future<dynamic> sendBackCall(dynamic body) async {
    final response = await _apiServices.getPostApiResponse(
      url: AppUrl.BACKCALL_URL,
      body: body,
    );
    return ApiResponseModel<dynamic>.fromJsonWithDynamic(response);
  }

  Future<ApiResponseModel<FaqListItem>> getFaq({dynamic body}) async {
    final response = await _apiServices.getPostApiResponse(
      url: AppUrl.FAQ_URL,
      body: body,
    );
    return ApiResponseModel<FaqListItem>.fromJson(
        response, (json) => FaqListItem.fromJson(json));
  }
}
