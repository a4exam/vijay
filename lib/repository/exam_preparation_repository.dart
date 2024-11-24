
import 'package:get/get.dart';
import 'package:mcq/data/network/base_api_services.dart';
import 'package:mcq/data/network/network_api_services.dart';
import 'package:mcq/models/exam_preparation/ExamPreparationListItem.dart';

class ExamPreparationRepository {
  final BaseApiServices _apiServices = Get.put(NetworkApiServices());


  Future<List<ExamPreparationListItem>> getExamPreparationListData() async {
    List<ExamPreparationListItem> list = [];
    try {
      final dynamic response = bodyResponse;
      if (response['responseCode'] == 1) {
        List<dynamic> responseData = response['data'];
        for (var item in responseData) {
          list.add(ExamPreparationListItem.fromJson(item));
        }
      }
    } catch (e) {
      return list;
    }
    return list;
  }
}

final bodyResponse = {
  "responseCode": 1,
  "responseMessage": "Exam preparation list data fetched  successfully",
  "data": [
    {
      "type": "board",
      "name": "UPSC",
      "id": "1",
      "image": "",
      "data": [
        {"name": "UPSC1", "id": "101"},
        {"name": "UPSC2", "id": "102"},
        {"name": "UPSC3", "id": "103"},
      ]
    },
    {
      "type": "board",
      "name": "Railway",
      "id": "2",
      "image": "",
      "data": [
        {"name": "UPSC1", "id": "101"},
        {"name": "Railway1", "id": "201"},
        {"name": "Railway2", "id": "202"},
        {"name": "Railway3", "id": "203"},
      ]
    },
    {
      "type": "board",
      "name": "SCC",
      "id": "3",
      "image": "",
      "data": [
        {"name": "SCC1", "id": "301"},
        {"name": "SCC2", "id": "302"},
        {"name": "SCC3", "id": "303"},
      ]
    },
    {
      "type": "category",
      "name": "Police",
      "id": "4",
      "image": "",
      "data": [
        {"name": "UP Police", "id": "401"},
        {"name": "Delhi Police", "id": "402"},
        {"name": "MP Police", "id": "403"},
      ]
    },
  ]
};
