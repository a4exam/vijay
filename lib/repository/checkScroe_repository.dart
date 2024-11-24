import 'dart:convert';

import 'package:get/get.dart';

import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../models/api_response_model.dart';
import '../models/checkScrore/checkExamResponse.dart';
import '../models/hero/alldescriptionresponse.dart';
import '../utils/app_url.dart';
import 'package:http/http.dart' as http;
class CheckScoreRepository{

  final BaseApiServices _apiServices = Get.put(NetworkApiServices());

  Future<dynamic> getExam() async {
    return await _apiServices.getPostApiResponse(
      url: AppUrl.GETEXAM_URL,

    );
  }
  Future<AllExamResponse?> fetchExams() async {
    final url = Uri.parse(AppUrl.GETEXAM_URL);

    try {
      final response = await http.get(url);

      // Log the HTTP response details


      if (response.statusCode == 200) {
        // Parse and return the response
        final jsonResponse = json.decode(response.body);
        print("Exam Data Url: ${url}");
        print("Status Code: ${response.statusCode}");
        print("Exam List Body : ${response.body}");
        return AllExamResponse.fromJson(jsonResponse);
      } else {
        print("Failed to load exams. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("An error occurred: $e");
      return null;
    }
  }

  Future<List<AllDescriptionResponse>> getAllDescription({
    String? questionId,
    required String token,
  }) async {
    final body = {"question_id": questionId};
    final response = await _apiServices.getPostApiResponse(
      url: AppUrl.allDescriptionUrl,
      token: token,
      body: body,
    );
    List<AllDescriptionResponse> descriptionList = [];

    if (response["responseCode"].toString() == "1") {
      List<dynamic> list = response["data"];
      descriptionList = list.map((e) => AllDescriptionResponse.fromJson(e)).toList();
    }
    return descriptionList;
  }
}