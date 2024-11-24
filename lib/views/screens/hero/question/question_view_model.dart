import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mcq/helpers/preferences_helper.dart';
import 'package:mcq/models/hero/question.dart';
import 'package:mcq/repository/hero_repository.dart';
import 'package:mcq/views/screens/hero/question/question_util.dart';
import 'package:http/http.dart' as http;
import '../../../../models/hero/alldescriptionresponse.dart';

class QuestionViewModel extends GetxController {
  final heroRepository = Get.put(HeroRepository());

  Timer? timer;
  RxString timeText = "00:00".obs;
  final String typeId;
  late String token;
  List<SeriesQuestion> seriesQuestions = [];
  int elapsedSeconds = 0, currentIndex = 0, page = 1;
  RxInt questionSeries = 1.obs;
  RxString questionFlag = "a".obs;
  File? descriptionImage;
   final TextEditingController _textController=TextEditingController();
  //List<AllDescriptionData> alldescription = [];
  Rx<Question?> currentQuestion = Rx<Question?>(null);
  List<Question> currentQuestionList = [];
  final int seriesCount;
  RxBool isShowPreviousButton = false.obs;
  RxBool isShowNextButton = false.obs;
  var alldescription = <AllDescriptionData>[].obs;

  RxBool loading = true.obs;

  QuestionViewModel({
    hasStartTime,
    required this.typeId,
    required this.seriesCount,
  }) {
    init();
    startTimer();
    hasStartTime?.listen((hasStartTime) {
      hasStartTime ? startTimer() : stopTimer();
    });
  }

  init() async {
    token = await PreferenceHelper.getToken();
    await getQuestion("1");
    if (seriesQuestions.isNotEmpty && seriesQuestions.first.questions!.isNotEmpty) {
      currentQuestion.value = seriesQuestions.first.questions!.first;
      currentQuestionList = getQuestionListAccordingToSeries("1");
      if (currentIndex == currentQuestionList.length - 1) {
        getQuestion((questionSeries.value + 1).toString());
      }
    }

  }

  Future<void> submitUserAnswer(String questionId, String chapterId, String userAnswer, String catId,) async {
    final isLoading = true.obs;

    final request = {
      "question_id":questionId,
      "chapter_id":chapterId,
      "user_ans":userAnswer,
      "cat_id":catId,
      "time":DateTime.now().toIso8601String()
    };

    print("Request Data: $request");

    try {
      var response = await heroRepository.postUserAnswer(
        body: request,
        token: token,
      );

      isLoading(false);

      if (response is Map<String, dynamic> && response.containsKey('statusCode') && response.containsKey('responseBody')) {
        final statusCode = response['statusCode'];
        final responseBody = response['responseBody'];

        if (responseBody is String) {
          final parsedResponseBody = json.decode(responseBody);
          final responseMessage = parsedResponseBody['responseMessage'] ?? "Successfully saved problem";
          final nestedStatusCode = parsedResponseBody['statusCode'];
          print("data saved............................: $responseBody");
          if (nestedStatusCode == 201) {
            /*Get.snackbar(
              "Success",
              responseMessage,
              colorText: Colors.white,
              backgroundColor: Colors.green,
            );*/

            print("Success");

            // Perform any additional actions needed after successful report
          } else {
            print("Data not saved: $responseBody");

            Get.snackbar(
              "Error",
              responseMessage,
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
          }
        } else {
          Get.snackbar(
            "Error",
            "Failed to save data. Received unexpected response from server.",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to save data. Received unexpected response from server.",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print("Data not saved: $e");
      isLoading(false);
      Get.snackbar(
        "Error",
        "Failed to submit report: ${e.toString()}",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }



  getQuestion(String seriesId) async {
    if (seriesId == "1") loading.value = true;
    setNextButtonV(false);
    final response = await heroRepository.getQuestions(
      token: token,
      seriesId: seriesId,
      typeId: typeId,
      page: "2",
    );
    if (response.isNotEmpty) {
      seriesQuestions.add(SeriesQuestion(
        seriesName: seriesId,
        questions: response,
      ));
      setNextButtonV(true);
    }

    if (seriesId == "1") loading.value = false;
  }

  startTimer() {
    timer != null ||
            (currentQuestion.value != null &&
                currentQuestion.value!.isSelectByUser.value)
        ? timer = null
        : timer = Timer.periodic(
            const Duration(seconds: 1),
            (timer) {
              elapsedSeconds++;
              serTimeText();
            },
          );
  }

  stopTimer() {
    timer?.cancel();
    timer = null;
  }

  serTimeText() {
    final minutes = elapsedSeconds ~/ 60;
    final seconds = elapsedSeconds % 60;
    final formattedMinutes = minutes.toString().padLeft(2, '0');
    final formattedSeconds = seconds.toString().padLeft(2, '0');
    timeText.value = '$formattedMinutes:$formattedSeconds';
  }

  void onPressedOption(bool isSelected, int index,
    String selectedOptionTitle,) {
    // questions[index].isSelectByUser.value = isSelected;
    // questions[index].elapsedSeconds = elapsedSeconds;
    // questions[index].selectedOptionByUser = selectedOptionTitle;
  }

  List<Question> getQuestionListAccordingToSeries(String series) {
    for (SeriesQuestion a in seriesQuestions) {
      if (a.seriesName == series) {
        return a.questions!;
      }
    }
    return [];
  }

  Future<void> nextPage() async {
    stopTimer();
    dataSaveOfPrev();
    currentIndex++;
    if (currentIndex > currentQuestionList.length - 1) {
      if (questionSeries.value == seriesCount) {
        currentIndex--;
        setNextButtonV(false);
        return;
      }
      currentQuestionList = getQuestionListAccordingToSeries(
          (questionSeries.value + 1).toString());

      currentIndex = 0;
      questionSeries.value++;
    }
    currentQuestion.value = currentQuestionList[currentIndex];
    questionFlag.value = currentQuestion.value!.questionno!;

    loadNextData();
    elapsedSeconds = currentQuestion.value!.elapsedSeconds;
    setPreviousButtonV(true);
    startTimer();
    serTimeText();
  }

  void loadNextData() {
    if (questionSeries.value + 1 > seriesCount) return;
    if (currentIndex == currentQuestionList.length - 1) {
      bool needMoreData = true;
      final nextQuestionSeries = (questionSeries.value + 1).toString();
      for (SeriesQuestion a in seriesQuestions) {
        if (a.seriesName == nextQuestionSeries && a.questions!.isNotEmpty) {
          needMoreData = false;
          break;
        }
      }
      if (needMoreData) getQuestion(nextQuestionSeries);
    }
  }

  void previousPage() {
    stopTimer();
    setNextButtonV(true);
    dataSaveOfPrev();

    if (currentIndex == 0) {
      questionSeries.value--;

      currentQuestionList =
          getQuestionListAccordingToSeries((questionSeries.value).toString());
      currentIndex = currentQuestionList.length - 1;
    } else {
      currentIndex--;
    }

    currentQuestion.value = currentQuestionList[currentIndex];
    questionFlag.value = currentQuestion.value!.questionno!;
    elapsedSeconds = currentQuestion.value!.elapsedSeconds;

    if (currentIndex == 0 && questionSeries.value == 1) {
      setPreviousButtonV(false);
    }
    startTimer();
    serTimeText();
  }

  dataSaveOfPrev() {
    currentQuestion.value?.elapsedSeconds = elapsedSeconds;
    serTimeText();
  }

  setPreviousButtonV(bool value) {
    if (isShowPreviousButton.value != value) {
      isShowPreviousButton.value = value;
    }
  }

  setNextButtonV(bool value) {
    if (isShowNextButton.value != value) {
      isShowNextButton.value = value;
    }
  }

  onTapEnableButton({
    required OptionFlag optionFlag,
    required bool hasEnableOption,
  }) {
    switch (optionFlag) {
      case OptionFlag.A:
        currentQuestion.value!.hasEnableOption1.value = hasEnableOption;
        break;
      case OptionFlag.B:
        currentQuestion.value!.hasEnableOption2.value = hasEnableOption;
        break;
      case OptionFlag.C:
        currentQuestion.value!.hasEnableOption3.value = hasEnableOption;
        break;
      case OptionFlag.D:
        currentQuestion.value!.hasEnableOption4.value = hasEnableOption;
        break;
    }
  }

  onTapOption({
    required OptionFlag optionFlag,
    required bool hasEnableOption,
  }) {
    if (hasEnableOption) {
      stopTimer();
      currentQuestion.value!.elapsedSeconds = elapsedSeconds;
      currentQuestion.value!.isSelectByUser.value = true;
      currentQuestion.value!.selectedOptionByUser =
          optionFlag.getOptionNumber();
    }
  }

  Future<void> getDescriptions(String questionId) async {
    if (questionId.isEmpty) {
      print("Invalid questionId");
      return;
    }

    loading(true);

    try {
      final List<AllDescriptionData> response = await heroRepository.getDescription(
        token: token,
        questionId: questionId,
      );


        alldescription.value = response;
        //isLiked = response.map<bool>((desc) => desc.likeUser == 'true').toList();

    } catch (e) {
      print("Error fetching descriptions: $e");
    } finally {
      loading(false);
    }
  }

  Future<void> saveData(Question question) async {
    loading(true);

    try {
      // Convert the image to bytes
      List<int>? imageBytes;
      if (descriptionImage != null) {
        imageBytes = await descriptionImage!.readAsBytes();
      }

      // Prepare the request data
      Map<String, dynamic> request = {
        'description': _textController.text,
        'question_id': question.id.toString(),
      };

      if (imageBytes != null) {
        request['image'] = base64Encode(imageBytes); // Convert image bytes to base64
      }

      print("Request Data: $request");

      var uri = Uri.parse('https://examopd.com/api/v1/saveUserDescription');

      var requestMultipart = http.MultipartRequest('POST', uri);
      requestMultipart.headers['Authorization'] = 'Bearer $token';
      requestMultipart.fields['description'] = _textController.text;
      requestMultipart.fields['question_id'] = question.id.toString();

      if (descriptionImage != null) {
        var stream = http.ByteStream(descriptionImage!.openRead());
        stream.cast();

        var length = await descriptionImage!.length();
        var multipartFile = http.MultipartFile(
          'image',
          stream,
          length,
          filename: descriptionImage!.path.split('/').last,
        );

        requestMultipart.files.add(multipartFile);
      }

      var response = await requestMultipart.send();
      var responseString = await response.stream.bytesToString();
      var responseBody = jsonDecode(responseString);

      loading(false);

      if (response.statusCode == 200) {
        final responseMessage = responseBody['responseMessage'] ?? "Unknown error occurred";
        final nestedStatusCode = responseBody['statusCode'];

        if (nestedStatusCode == 201) {
          print("submitted questioned: ${question.id}");
          Get.snackbar(
            "Success",
            responseMessage,
            colorText: Colors.white,
            backgroundColor: Colors.green,
          );

          // Fetch updated descriptions for the current question ID
          await getDescriptions(question.id.toString());


            _textController.clear();
            descriptionImage = null; // Clear selected file after saving

        } else {
          Get.snackbar(
            "Error",
            responseMessage,
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to save data. Received unexpected response from server.",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      loading(false);
      Get.snackbar(
        "Error",
        "Failed to save data: ${e.toString()}",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }


}
