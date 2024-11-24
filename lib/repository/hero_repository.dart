import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mcq/data/network/base_api_services.dart';
import 'package:mcq/data/network/network_api_services.dart';
import 'package:mcq/models/comman/IdName.dart';
import 'package:mcq/models/hero/chapter.dart';
import 'package:mcq/models/hero/hero_response.dart';
import 'package:mcq/models/hero/question.dart';
import 'package:mcq/models/hero/question_type.dart';
import 'package:mcq/utils/app_url.dart';
import '../models/hero/alldescriptionresponse.dart';
import '../models/hero/descriptionlikeresponse.dart';
import '../models/hero/savedescriptionResponse.dart';

class HeroRepository {
  final BaseApiServices _apiServices = Get.put(NetworkApiServices());

  Future<HeroResponse> getHeroQuestions({
    dynamic body,
    required int page,
  }) async {
    final response = await _apiServices.getPostApiResponse(
      body: AppUrl.heroQuestionsURL(page),
      url: body,
    );

    return HeroResponse.fromJson(response);
  }

  Future<List<IdName>> getSubject({
    String? catId,
    required String token,
  }) async {
    final body = {"catId": catId};
    final response = await _apiServices.getPostApiResponse(
      url: AppUrl.subjectUrl,
      token: token,
      body: body,
    );
    List<IdName> subjects = [];
    if (response["responseCode"].toString() == "1") {
      List<dynamic> list = response["data"];
      for (dynamic item in list) {
        subjects.add(IdName(
          id: item["id"].toString(),
          name: item["name"],
        ));
      }
    }
    return subjects;
  }

  Future<List<Chapter>> getChapters({
    String? bookId,
    required String token,
  }) async {
    final body = {"bookId": bookId};
    final response = await _apiServices.getPostApiResponse(
      url: AppUrl.chapterUrl,
      token: token,
      body: body,
    );
    List<Chapter> chapters = [];
    if (response["responseCode"].toString() == "1") {
      List<dynamic> list = response["data"];
      for (dynamic item in list) {
        chapters.add(Chapter.fromJson(item));
      }
    }
    return chapters;
  }

  Future<List<IdName>> getBooks({
    String? subId,
    required String token,
  }) async {
    final body = {"subjId": subId};
    final response = await _apiServices.getPostApiResponse(
      url: AppUrl.bookUrl,
      token: token,
      body: body,
    );
    List<IdName> books = [];
    if (response["responseCode"].toString() == "1") {
      List<dynamic> list = response["data"];
      for (dynamic item in list) {
        books.add(IdName(
          id: item["id"].toString(),
          name: item["name"],
        ));
      }
    }
    return books;
  }

  Future<List<QuestionType>> getQuestionType({
    String? chapterId,
    required String token,
  }) async {
    final body = {"chapterId": chapterId};
    final response = await _apiServices.getPostApiResponse(
      url: AppUrl.questionTypesUrl,
      token: token,
      body: body,
    );
    List<QuestionType> questionType = [];

    if (response["responseCode"].toString() == "1") {
      List<dynamic> list = response["data"];
      questionType = list.map((e) => QuestionType.fromJson2(e)).toList();
    }
    return questionType;
  }

  Future<List<DescriptionLikeResponse>> getDescriptionLikes({
    String? descriptionId,
    String? questionId,
    String? type,
    String? comment,
    required String token,
  }) async {
    final body = {"description_id": descriptionId, "question_id":questionId,"type":type,"comment":comment};
    final response = await _apiServices.getPostApiResponse(
      url: AppUrl.descriptionLikesUrl,
      token: token,
      body: body,
    );
    List<DescriptionLikeResponse> descriptionLikes = [];

    if (response["responseCode"].toString() == "1") {
      List<dynamic> list = response["data"];
      descriptionLikes = list.map((e) => DescriptionLikeResponse.fromJson(e)).toList();
    }
    return descriptionLikes;
  }

  Future<List<Question>> getQuestions({
    String? typeId,
    String? seriesId,
    String? page,
    required String token,
  }) async {
    final body = {
      "typeId": typeId,
      "series": seriesId,
      "page": page,
    };
    final response = await _apiServices.getPostApiResponse(
      url: AppUrl.questionUrl,
      token: token,
      body: body,
    );
    List<Question> questions = [];

    if (response["responseCode"].toString() == "1") {
      List<dynamic> list = response["data"];
      questions = list.map((e) => Question.fromJson(e)).toList();

    }

    return questions;
  }



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
  Future<dynamic> postUserAnswer({required Map<String, dynamic> body, required String token}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      Uri.parse(AppUrl.saveUserAnswerUrl),
      headers: headers,
      body: jsonEncode(body),
    );

    print("URL: ${AppUrl.saveUserAnswerUrl}");
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
  Future<dynamic> omrResult({required Map<String, dynamic> body, required String token}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      Uri.parse(AppUrl.userReportUrl),
      headers: headers,
      body: jsonEncode(body),
    );

    print("URL: ${AppUrl.GETOMRmRESULT_URL}");
    print("REQUEST DATA: $body");
    print("RESPONSE STATUS: ${response.statusCode}");
    print("RESPONSE BODY: ${response.body}");

    return {
      'statusCode': response.statusCode,
      'responseBody': response.body,
      'responseMessage': jsonDecode(response.body)['message'] ?? 'No message',
    };
  }

  Future<dynamic> updateDescription({
    required Map<String, dynamic> body,
    required String token,
    required String url, // Pass the full URL as an argument
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    print("URL: $url");
    print("REQUEST DATA: $body");
    print("RESPONSE STATUS: ${response.statusCode}");
    print("RESPONSE BODY: ${response.body}");

    final responseBody = jsonDecode(response.body);
    return {
      'statusCode': response.statusCode,
      'responseBody': responseBody,
      'responseMessage': responseBody['message'] ?? 'No message',
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

