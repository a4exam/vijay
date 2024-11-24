import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:mcq/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  dynamic responseJson;
  int indexsolution =0;
  final failedResponseJson = {
    "responseCode": "0",
    "responseMessage": "Something Wrong"
  };
  final successResponseJson = {"responseCode": "1", "responseMessage": "Done"};

  _headers(token) => token == null ? null : {'Authorization': 'Bearer $token'};

  _encoding(token) => token == null ? null : Encoding.getByName("utf-8");

  _showError(e, String url) {
    if (kDebugMode) {
      print("URL: ");
      print(url);
      print("ERROR: ");
      print(e);
    }
  }

  @override
  Future getPostApiResponse({
    required String url,
    String? token,
    dynamic body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: _headers(token),
        encoding: _encoding(token),
      );
      responseJson = returnResponse(
        url: url,
        body: body,
        responseData: response.body,
        statusCode: response.statusCode,
      );
    } catch (e) {
      _showError(e, url);
      return failedResponseJson;
    }

    return responseJson;
  }

  @override
  Future getGetApiResponse({
    required String url,
    String? token,
    dynamic body,
  }) async {
    try {
      // final headers = token == null
      //     ? null
      //     : {
      //         'Content-Type': 'application/json',
      //         'Authorization': 'Bearer $token',
      //       };
      final response = await http.get(
        Uri.parse(url),
        headers: _headers(token),
      );
      responseJson = returnResponse(
        url: url,
        body: body,
        statusCode: response.statusCode,
        responseData: response.body,
      );
    } catch (e) {
      _showError(e, url);
      return failedResponseJson;
    }
    return responseJson;
  }

  @override
  Future<dynamic> getPostMultipartApiResponse({
    required String url,
    String? token,
    dynamic body,
    required File file,
    String? fileName,
    required String fileFieldName,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      if (body != null) {
        request.fields.addAll(body);
      }
      var multipartFile =
          await fileToMultipartFile(file: file, fileFieldName: fileFieldName);

      request.files.add(multipartFile);
      final response = await request.send();

      if (kDebugMode) {
        print("URL: ");
        print(url);
        if (body != null) {
          print("REQUEST DATA: ");
          print(body);
        }
        print("RESPONSE DATA: ");
        print(successResponseJson);
      }
      return response.statusCode == 200
          ? successResponseJson
          : failedResponseJson;
    } catch (e) {
      _showError(e, url);
      return failedResponseJson;
    }
  }

  Future<http.MultipartFile> fileToMultipartFile({
    required File file,
    required String fileFieldName,
    String? fileName,
  }) async {
    fileName ??= file.path.split('/').last;
    var stream = http.ByteStream(file.openRead());
    var length = await file.length();
    var multipartFile = http.MultipartFile(
      fileFieldName,
      stream,
      length,
      filename: fileName,
    );
    return multipartFile;
  }

  dynamic returnResponse({
    required String url,
    dynamic body,
    dynamic responseData,
    required int statusCode,
  }) {
    if (kDebugMode) {
      print("URL: ");
      print(url);
      if (body != null) {
        print("REQUEST DATA: ");
        print(body);
      }
      print("RESPONSE DATA: ");
      print(jsonDecode(responseData));
    }
    return statusCode == 200 ? jsonDecode(responseData) : failedResponseJson;
  }
}
