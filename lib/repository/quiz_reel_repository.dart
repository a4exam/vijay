import 'dart:convert';

import 'package:get/get.dart';
import 'package:mcq/models/quizReel/quizreelresponse.dart';

import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../models/api_response_model.dart';
import '../models/checkScrore/checkExamResponse.dart';
import '../models/hero/alldescriptionresponse.dart';
import '../utils/app_url.dart';
import 'package:http/http.dart' as http;
class QuizReelRepository{

  final BaseApiServices _apiServices = Get.put(NetworkApiServices());



  Future<List<AllDescriptionData>> getDescription({
    required String token,
    required String questionId,

  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var request = http.Request('POST', Uri.parse(AppUrl.allDescriptionUrl));
    request.body = json.encode({
      "question_id": questionId,

    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("URL: ${request.url}");
    print("REQUEST DATA: ${request.body}");
    print("RESPONSE STATUS: ${response.statusCode}");

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE BODY: $responseBody");

      try {
        var jsonData = jsonDecode(responseBody);
        if (jsonData['data'] is List) {
          List<dynamic> data = jsonData['data'];
          return data.map((e) => AllDescriptionData.fromJson(e)).toList();
        } else {
          print("Expected list but got: ${jsonData['data']}");
          return [];
        }
      } catch (e) {
        print("Error parsing JSON: $e");
        return [];
      }
    } else {
      print("Error: ${response.reasonPhrase}");
      return [];
    }
  }
  Future<List<QuizReelData>> getQuestions({
    String?  questionId,

    required String token,
  }) async {
    final body = {
      "question_id": questionId,
    };
    final response = await _apiServices.getPostApiResponse(
      url: 'https://examopd.com/api/v1/quiz-real',
      token: token,
      body: body,
    );
    List<QuizReelData> questions = [];

    if (response["responseCode"].toString() == "1") {
      List<dynamic> list = response["data"];
      questions = list.map((e) => QuizReelData.fromJson(e)).toList();

    }

    return questions;
  }
  Future<dynamic> postDescription({required Map<String, dynamic> body, required String token}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      Uri.parse(AppUrl.saveUserDescriptionUrl),
      headers: headers,
      body: jsonEncode(body),
    );

    print("URL: ${AppUrl.saveUserDescriptionUrl}");
    print("REQUEST DATA: $body");
    print("RESPONSE STATUS: ${response.statusCode}");
    print("RESPONSE BODY: ${response.body}");

    return {
      'statusCode': response.statusCode,
      'responseBody': response.body,
      'responseMessage': jsonDecode(response.body)['message'] ?? 'No message',
    };
  }
  Future<dynamic> postDescriptionLikes({required Map<String, dynamic> body, required String token}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      Uri.parse(AppUrl.descriptionLikesUrl),
      headers: headers,
      body: jsonEncode(body),
    );

    print("URL: ${AppUrl.descriptionLikesUrl}");
    print("REQUEST DATA: $body");
    print("RESPONSE STATUS: ${response.statusCode}");
    print("RESPONSE BODY: ${response.body}");

    return {
      'statusCode': response.statusCode,
      'responseBody': response.body,
      'responseMessage': jsonDecode(response.body)['message'] ?? 'No message',
    };
  }

  Future<dynamic> reportUser({required Map<String, dynamic> body, required String token}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      Uri.parse(AppUrl.userReportUrl),
      headers: headers,
      body: jsonEncode(body),
    );

    print("URL: ${AppUrl.userReportUrl}");
    print("REQUEST DATA: $body");
    print("RESPONSE STATUS: ${response.statusCode}");
    print("RESPONSE BODY: ${response.body}");

    return {
      'statusCode': response.statusCode,
      'responseBody': response.body,
      'responseMessage': jsonDecode(response.body)['message'] ?? 'No message',
    };
  }
  Future<bool> sendQuestionReport({
    required String questionId,
    required String questionLanguage,
    required String reportQuestion,
    required String reportOptionA,
    required String reportOptionB,
    required String reportOptionC,
    required String reportOptionD,
    required String userNote,
    String ?description,
    required String reportCorrectAnswer,
    required String token,
  }) async {
    final body = {
      "question_id": questionId,
      "question_language": questionLanguage,
      "report_question": reportQuestion,
      "report_option_a": reportOptionA,
      "report_option_b": reportOptionB,
      "report_option_c": reportOptionC,
      "report_option_d": reportOptionD,
      "user_notes": userNote,
      "report_description": description,
      "report_correct_answer": reportCorrectAnswer,
    };

    final response = await http.post(
      Uri.parse(AppUrl.questionReportUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    print("URL: ${AppUrl.questionReportUrl}");
    print("REQUEST DATA: $body");
    print("RESPONSE STATUS: ${response.statusCode}");
    print("RESPONSE BODY: ${response.body}");

    if (response.statusCode == 200) {
      // Assuming the API returns a success message in the response body
      return true;
    } else {
      // Handle the error response
      return false;
    }
  }
}