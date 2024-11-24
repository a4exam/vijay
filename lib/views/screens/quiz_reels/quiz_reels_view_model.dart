import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mcq/repository/quiz_reel_repository.dart';
import 'package:mcq/views/screens/quiz_reels/quiz_reel_utils.dart';
import 'package:mcq/models/quizReel/quizreelresponse.dart';
import 'package:mcq/helpers/preferences_helper.dart';

import '../../../models/hero/alldescriptionresponse.dart';
import '../../../themes/color.dart';

class QuizReelsViewModel extends GetxController {
  final quizReelRepository = Get.put(QuizReelRepository());
  bool? isFromHome;
  String? questionLanguage;
  RxBool isQuestionLanguageEn = true.obs;
  var selectedOptionIndex = Rxn<int>();
  int elapsedSeconds = 0;
  late ValueNotifier<bool> isTextNotEmpty;
  Timer? timer;
  RxString selectedOption = 'A'.obs;
  Future<QuizReelResponse>? quizReelResponse;
  RxBool isLoading = false.obs;
  RxBool showDescription = false.obs;
  RxString timeText = "00:00".obs;
  final TextEditingController textController = TextEditingController();
  bool isHindi = true;
  Map<int, int?> optionSelections = {}; // To store the selected option index for each question
  RxString errorMessage = ''.obs;
  Rx<QuizReelData?> currentQuestion = Rx<QuizReelData?>(null);
  var alldescription = <AllDescriptionData>[].obs;
  late String token;
  final ImagePicker picker = ImagePicker();
  File? descriptionImage;
  RxInt currentPageIndex = 0.obs;
  RxInt likeValue = 0.obs;
  RxBool descriptionToggle = true.obs;
  RxBool isLiked = true.obs;
  final RxList<QuizReelData> quizData = <QuizReelData>[].obs; // Store fetched questions
 // Add this flag to manage loading state
  QuizReelsViewModel({this.isFromHome}) {
    
    questionLanguage = "en";
    isTextNotEmpty = ValueNotifier<bool>(false);

  }

  dynamic hasStartTime;

  @override
  void onInit() async {
    super.onInit();
    startTimer();

    hasStartTime?.listen((hasStartTime) {
      hasStartTime ? startTimer() : stopTimer();
    });
    try {
      token = await PreferenceHelper.getToken();
      fetchQuizData(); // Fetch quiz data only after the token is initialized
    } catch (e) {
      print('Error initializing token: $e');
    }

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
  void reportQuestionBottomSheet(BuildContext context,QuizReelData question) async {
    File? selectedImage;

    TextEditingController questionController = TextEditingController(text: questionLanguage == "en"?question.question:question.questionHi);

    List<TextEditingController> optionControllers = [
      TextEditingController(text: questionLanguage == "en"?question.options1:question.options1Hi),
      TextEditingController(text: questionLanguage == "en"?question.options2:question.options2Hi),
      TextEditingController(text: questionLanguage == "en"?question.options3:question.options3Hi),
      TextEditingController(text: questionLanguage == "en"?question.options4:question.options4Hi),
    ];

    TextEditingController problemController = TextEditingController();



    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor, // Blue color matching your images
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.arrow_back, size: 25, color: Colors.white),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        "Question Report",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.highlight_remove, size: 25, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      TextField(
                        controller: questionController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        style: const TextStyle(fontSize: 20),
                        maxLines: null, // Allow unlimited lines (automatically expands as needed)
                        minLines: 1, // Start with one line
                        keyboardType: TextInputType.multiline, // Enable multiline input
                      ),

                      const SizedBox(height: 20),
                      ...List.generate(4, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            minLines: 1,//Normal textInputField will be displayed
                            maxLines: 5,// when user presses enter it will adapt to it
                            controller: optionControllers[index],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            style: const TextStyle(fontSize: 16),
                            // Making option text non-editable
                          ),
                        );
                      }),
                      const SizedBox(height: 10),
                      Obx(
                            () => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("CorrectOption", style: TextStyle(
                                fontSize: 18
                            ),),
                            const SizedBox(width: 10,),
                            SizedBox(
                              width: 40,
                              child: DropdownButton<String>(
                                value: selectedOption.value,  // Access the RxString value
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    selectedOption.value = newValue;  // Update the RxString value
                                  }
                                },
                                items: ['A', 'B', 'C', 'D']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    enabled: true,
                                    child: Text(value),
                                  );
                                }).toList(),
                                isExpanded: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: problemController,

                        decoration: InputDecoration(
                          hintText: "Write about the note",
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.camera_alt),
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                selectedImage = File(image.path);
                                Get.snackbar(
                                  "Image Selected",
                                  "Image: ${image.name}",
                                  colorText: Colors.white,
                                  backgroundColor: Colors.green,
                                );
                              }
                            },
                          ),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        maxLines: 3,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      if (selectedImage != null)
                        Text(
                          "Image Selected: ${selectedImage!.path.split('/').last}",
                          style: const TextStyle(color: Colors.green, fontSize: 16),
                        ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (questionController.text.isNotEmpty) {

                                  isLoading(true);



                                final update = await quizReelRepository.sendQuestionReport(
                                  questionId: question.id.toString(),
                                  questionLanguage: question.questionHi.toString()??"Hindi",
                                  reportQuestion: questionController.text,
                                  reportOptionA: optionControllers[0].text,
                                  reportOptionB: optionControllers[1].text,
                                  reportOptionC: optionControllers[2].text,
                                  reportOptionD: optionControllers[3].text,
                                  userNote: problemController.text,
                                  reportCorrectAnswer: selectedOption.toString(),
                                  token: token, // Replace with actual token
                                );

                                  isLoading( false);

                                if (update) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        content: Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Icon at the top
                                              Container(
                                                padding: const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.blue.withOpacity(0.1),
                                                ),
                                                child: const Icon(
                                                  Icons.check_circle_outline,
                                                  size: 50,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              // Title
                                              const Text(
                                                'Update Success',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              // Subtitle
                                              const Text(
                                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fames velit.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              // Close button
                                              SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Get.back();
                                                    Get.back();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.blue,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                  child: const Text('Close'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  Get.snackbar(
                                    "Error",
                                    "Failed to submit question report",
                                    colorText: Colors.white,
                                    backgroundColor: Colors.red,
                                  );
                                }
                              } else {
                                Get.snackbar(
                                  "Error",
                                  "Description cannot be empty and option must be selected",
                                  colorText: Colors.white,
                                  backgroundColor: Colors.red,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 120),
                            ),
                            child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 15)),
                          ),

                        ],
                      ),
                      SizedBox(height: Get.height / 4),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {

        descriptionImage = File(pickedFile.path);

    } else {
      print('No image selected');
    }
  }


  void toggleDescription() {
    showDescription.value = !showDescription.value;
  }

  void onNavigateToNext() async {
    if (currentPageIndex.value < quizData.length - 1) {
      currentPageIndex.value++;
      getAllDescription(quizData[currentPageIndex.value].id.toString());
    } else {
      await fetchQuizData();
    }
  }

  void onNavigateToPrevious() async {
    if (currentPageIndex.value > 0) {
      currentPageIndex.value--;
      getAllDescription(quizData[currentPageIndex.value].id.toString());
    }
  }



  void toggleLanguage() {
    isQuestionLanguageEn.value = !isQuestionLanguageEn.value;
    questionLanguage = (questionLanguage == "en") ? "hi" : "en";
    fetchQuizData(); // Refetch quiz data when language changes
  }

  Future<void> fetchQuizData() async {
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse('https://examopd.com/api/v1/quiz-real'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final newQuizData = QuizReelResponse.fromJson(responseBody);
        quizData.add(newQuizData.data!);
        currentPageIndex.value = quizData.length-1;
        await getAllDescription(quizData[currentPageIndex.value].id.toString());


      } else {
        throw Exception('Failed to load quiz data');
      }
    } catch (e) {
      print("Error fetching quiz data: $e");
    } finally {

      isLoading.value = false;

    }
  }
  Future<void> submitQuizAnswer(String questionId,  String ans, String authToken) async {
    final url = Uri.parse('https://examopd.com/api/v1/save-quiz-real-ans');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken', // Add your token here
    };
    final body = jsonEncode({
      'question_id': questionId,
      'time': 'time',
      'ans': ans,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Response data: ${response.body}');
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
        print('Response message: ${response.body}');
      }
    } catch (e) {
      // Handle exception
      print('Exception: $e');
    }
  }



  Future<void> saveData(String? textDescription, String? id) async {
    isLoading.value = true;

    try {
      List<int>? imageBytes;
      if (descriptionImage != null) {
        imageBytes = await descriptionImage!.readAsBytes();
      }

      var uri = Uri.parse('https://examopd.com/api/v1/saveUserDescription');
      var requestMultipart = http.MultipartRequest('POST', uri);
      requestMultipart.headers['Authorization'] = 'Bearer $token';
      requestMultipart.fields['description'] = textDescription.toString();
      requestMultipart.fields['question_id'] = id.toString();

      if (imageBytes != null) {
        var stream = http.ByteStream(descriptionImage!.openRead());
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

      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseMessage = responseBody['responseMessage'] ?? "Unknown error occurred";
        final nestedStatusCode = responseBody['statusCode'];

        if (nestedStatusCode == 201) {
          Get.snackbar(
            "Success",
            responseMessage,
            colorText: Colors.white,
            backgroundColor: Colors.green,
          );

          descriptionImage = null; // Clear selected file after saving
          print("save Data: $responseBody");
          // Call the getAllDescription method to refresh the list
          await getAllDescription(id!);
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
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Failed to save data: ${e.toString()}",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> getAllDescription(String questionId) async {
    if (questionId.isEmpty) {
      print("Invalid questionId");
      return;
    }

    isLoading.value = true;

    try {
      // Fetch the raw response as List<AllDescriptionData>
      final List<AllDescriptionData> response = await quizReelRepository.getDescription(
        token: token,
        questionId: questionId,
      );

      print("Fetched descriptions: ${response.length} items");

      // Convert questionId to integer for comparison
      final int questionIdInt = int.tryParse(questionId) ?? 0;

      // Filter the descriptions by questionId
      final List<AllDescriptionData> filteredDescriptions = response.where((description) {
        return description.questionId == quizData[currentPageIndex.value].id;
      }).toList();

      print("Filtered descriptions: ${filteredDescriptions.length} items");

      alldescription.value = filteredDescriptions;

    } catch (e) {
      print("Error fetching descriptions: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendCommentRequest(String descriptionId, String questionId, String comment) async {
    const url = 'https://examopd.com/api/v1/descriptionLikes';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      'description_id': descriptionId,
      'question_id': questionId,
      'type': 'comment',
      'comment': comment,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Request successful: ${response.body}');
      } else {
        // Handle error
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Error: $e');
    }
  }
  Future<void> sendLikeRequest(String descriptionId, String questionId, int like) async {
    const url = 'https://examopd.com/api/v1/descriptionLikes';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      'description_id': descriptionId,
      'question_id': questionId,
      'type': 'like',
      'like': like,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Request successful: ${response.body}');
      } else {
        // Handle error
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Error: $e');
    }
  }

  Future<void> toggleLike(int index) async {
    final isCurrentlyLiked = alldescription[index].isLike ?? false;
    final actionType = isCurrentlyLiked ? 'dislike' : 'like';

    // Optimistically update the UI

      alldescription[index].isLike = !isCurrentlyLiked;
      if (isCurrentlyLiked) {
        alldescription[index].likes = (alldescription[index].likes ?? 0)-1;
      } else {
        alldescription[index].likes = (alldescription[index].likes ?? 0) + 1;
      }


    final request = {
      'description_id': alldescription[index].id.toString(),
      'question_id': alldescription[index].questionId.toString(),
      'type': actionType,
    };

    try {
      var response = await quizReelRepository.postDescriptionLikes(body: request, token: token);

      if (response is Map<String, dynamic> &&
          response.containsKey('statusCode') &&
          response.containsKey('responseBody')) {
        final responseBody = response['responseBody'];

        if (responseBody is String) {
          final parsedResponseBody = json.decode(responseBody) as Map<String, dynamic>;
          final nestedStatusCode = parsedResponseBody['statusCode'];
          final responseMessage = parsedResponseBody['responseMessage'] ?? "Unknown error";
          final likesData = parsedResponseBody['data']['likes'];

          if (nestedStatusCode == 201) {

              alldescription[index].likes = (likesData is int)
                  ? likesData
                  : int.tryParse(likesData.toString()) ?? (alldescription[index].likes ?? 0);


            print("LIked");

            /* Get.snackbar(
              "Success",
              responseMessage,
              colorText: Colors.white,
              backgroundColor: Colors.green,
            );*/
          } else {
            // Revert the optimistic UI update on failure

              alldescription[index].isLike = isCurrentlyLiked;
              alldescription[index].likes = isCurrentlyLiked
                  ? (alldescription[index].likes ?? 0) + 1
                  : (alldescription[index].likes ?? 0) - 1;


            Get.snackbar(
              "Error",
              responseMessage,
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
          }
        } else {
          // Revert the optimistic UI update on unexpected response format

            alldescription[index].isLike = isCurrentlyLiked;
            alldescription[index].likes = isCurrentlyLiked
                ? (alldescription[index].likes ?? 0) + 1
                : (alldescription[index].likes ?? 0) - 1;

          Get.snackbar(
            "Error",
            "Failed to parse response. Received unexpected response format.",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } else {
        // Revert the optimistic UI update on server error

          alldescription[index].isLike = isCurrentlyLiked;
          alldescription[index].likes = isCurrentlyLiked
              ? (alldescription[index].likes ?? 0) + 1
              : (alldescription[index].likes ?? 0) - 1;

        Get.snackbar(
          "Error",
          "Failed to save action. Received unexpected response from server.",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      // Revert the optimistic UI update on exception

        alldescription[index].isLike = isCurrentlyLiked;
        alldescription[index].likes = isCurrentlyLiked
            ? (alldescription[index].likes ?? 0) + 1
            : (alldescription[index].likes ?? 0) - 1;


      Get.snackbar(
        "Error",
        "Failed to save action: ${e.toString()}",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
  String timeAgo(DateTime dateTime) {
    final Duration diff = DateTime.now().difference(dateTime);

    if (diff.inSeconds < 60) {
      return 'just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} minutes ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hours ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return DateFormat('yMMMd').format(dateTime); // Format as a date if more than a week ago
    }
  }

  void showCommentSheet(BuildContext context, int index) {


    // Comment controller
    final TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: Get.height / 2,
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    width: 40.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  const Text(
                    'Comments',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Divider(),
                  // List of comments
                  alldescription[index].commentUser!.isEmpty
                      ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('No comments available.'),
                  )
                      : ListView.builder(
                    shrinkWrap: true,
                    itemCount: alldescription[index].commentUser!.length,
                    itemBuilder: (context, commentIndex) {

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: ClipOval(
                                      child: alldescription[index].userImage != null &&
                                          alldescription[index].userImage!.isNotEmpty
                                          ? Image.network(
                                        alldescription[index].userImage!.toString(),
                                        fit: BoxFit.cover,
                                      )
                                          : Image.asset("assets/images/profile.png"),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(alldescription[index].userName ?? "Unknown",style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                    ),),
                                    const SizedBox(width: 10,),
                                    Text(timeAgo(DateTime.parse(alldescription[index].commentUser![index].createdAt.toString())) ?? "Unknown time",


                                        style:  const TextStyle(color: Colors.grey,

                                        )),

                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(alldescription[index].commentUser![index].comment ?? "",
                                      textAlign: TextAlign.left,
                                      maxLines: 3, // Adjust this to fit your design
                                      overflow: TextOverflow.ellipsis,

                                      style:  const TextStyle(color: Colors.black87,
                                          fontSize: 18
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            const Divider(),




                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            decoration: const InputDecoration(
                              hintText: 'Add a comment...',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () async {
                            String commentText = commentController.text;
                            if (commentText.isNotEmpty) {
                              // Create a new comment user instance
                              CommentUser newComment = CommentUser(
                                id: (alldescription[index].commentUser!.length + 1), // Example ID
                                userId: 1, // Replace with actual user ID
                                questionId: alldescription[index].questionId,
                                descriptionId: alldescription[index].id,
                                comment: commentText,
                                createdAt: DateTime.now().toIso8601String(),
                                userData: UserData(
                                  name: "Your Name", // Replace with actual user data
                                  images: "assets/images/profile.png",
                                ),
                              );

                              // Create request body for saving comment
                              final request = constructRequestBody(
                                descriptionId: alldescription[index].id!,
                                questionId: alldescription[index].questionId!,
                                type: 'comment',
                                comment: commentText,
                              );

                              try {
                                var response = await quizReelRepository.postDescriptionLikes(body: request, token: token);

                                if (response is Map<String, dynamic> &&
                                    response.containsKey('statusCode') &&
                                    response.containsKey('responseBody')) {
                                  final responseBody = response['responseBody'];

                                  if (responseBody is String) {
                                    final parsedResponseBody = json.decode(responseBody) as Map<String, dynamic>;
                                    final nestedStatusCode = parsedResponseBody['statusCode'];
                                    final responseMessage = parsedResponseBody['responseMessage'] ?? "Unknown error";

                                    if (nestedStatusCode == 201) {
                                      // Update the local list of comments

                                        alldescription[index].commentUser = (alldescription[index].commentUser ?? [])..add(newComment);


                                      Get.snackbar(
                                        "Success",
                                        responseMessage,
                                        colorText: Colors.white,
                                        backgroundColor: Colors.green,
                                      );
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
                                      "Failed to parse response. Received unexpected response format.",
                                      colorText: Colors.white,
                                      backgroundColor: Colors.red,
                                    );
                                  }
                                } else {
                                  Get.snackbar(
                                    "Error",
                                    "Failed to save comment. Received unexpected response from server.",
                                    colorText: Colors.white,
                                    backgroundColor: Colors.red,
                                  );
                                }
                              } catch (e) {
                                Get.snackbar(
                                  "Error",
                                  "Failed to save comment: ${e.toString()}",
                                  colorText: Colors.white,
                                  backgroundColor: Colors.red,
                                );
                              }

                              // Close the bottom sheet
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Map<String, dynamic> constructRequestBody({required int descriptionId, required int questionId, required String type, String? comment,}) {
    final request = {
      'description_id': descriptionId.toString(),
      'question_id': questionId.toString(),
      'type': type,
    };
    if (type == 'comment' && comment != null) {
      request['comment'] = comment;
    }
    return request;
  }


  Future<void> handleAction({required int index, required String type, String? comment,}) async {
    final request = constructRequestBody(
      descriptionId: alldescription[index].id!,
      questionId: alldescription[index].questionId!,
      type: type,
      comment: comment,
    );

    // Initial state storage for rollback if needed
    bool initialIsLike = alldescription[index].isLike ?? false;
    bool initialIsFavourite = alldescription[index].isFavourite ?? false;
    int initialLikes = alldescription[index].likes ?? 0;
    int initialFavourites = alldescription[index].favourite ?? 0;

    // Optimistic UI update

      if (type == 'like') {
        if (initialIsLike) {
          alldescription[index].isLike = false;
          alldescription[index].likes = initialLikes - 1;
        } else {
          alldescription[index].isLike = true;
          alldescription[index].likes = initialLikes + 1;
        }
      } else if (type == 'dislike') {
        if (initialIsLike) {
          alldescription[index].isLike = false;
          alldescription[index].likes = initialLikes - 1;
        }
        // Additional logic for dislikes if needed
      } else if (type == 'favourite') {
        if (initialIsFavourite) {
          alldescription[index].isFavourite = false;
          alldescription[index].favourite = initialFavourites - 1;
        } else {
          alldescription[index].isFavourite = true;
          alldescription[index].favourite = initialFavourites + 1;
        }
      } else if (type == 'unfavourite') {
        if (initialIsFavourite) {
          alldescription[index].isFavourite = false;
          alldescription[index].favourite = initialFavourites - 1;
        }
        // Additional logic for unfavouriting if needed
      }


    try {
      var response = await quizReelRepository.postDescriptionLikes(body: request, token: token);

      if (response is Map<String, dynamic> &&
          response.containsKey('statusCode') &&
          response.containsKey('responseBody')) {
        final responseBody = response['responseBody'];

        if (responseBody is String) {
          final parsedResponseBody = json.decode(responseBody) as Map<String, dynamic>;
          final nestedStatusCode = parsedResponseBody['statusCode'];
          final responseMessage = parsedResponseBody['responseMessage'] ?? "Unknown error";
          final likesData = parsedResponseBody['data']['likes'];
          final favouritesData = parsedResponseBody['data']['favourites'];

          if (nestedStatusCode == 201) {

              if (type == 'like' || type == 'dislike') {
                alldescription[index].likes = (likesData is int) ? likesData : int.tryParse(likesData.toString()) ?? initialLikes;
              } else if (type == 'favourite' || type == 'unfavourite') {
                alldescription[index].favourite = (favouritesData is int) ? favouritesData : int.tryParse(favouritesData.toString()) ?? initialFavourites;
              }


            Get.snackbar(
              "Success",
              responseMessage,
              colorText: Colors.white,
              backgroundColor: Colors.green,
            );
          } else {
            // Revert to initial state on failure

              alldescription[index].isLike = initialIsLike;
              alldescription[index].isFavourite = initialIsFavourite;
              alldescription[index].likes = initialLikes;
              alldescription[index].favourite = initialFavourites;


            Get.snackbar(
              "Error",
              responseMessage,
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
          }
        } else {
          // Unexpected response format, revert to initial state

            alldescription[index].isLike = initialIsLike;
            alldescription[index].isFavourite = initialIsFavourite;
            alldescription[index].likes = initialLikes;
            alldescription[index].favourite = initialFavourites;

          Get.snackbar(
            "Error",
            "Failed to parse response. Received unexpected response format.",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } else {
        // Revert to initial state on server error

          alldescription[index].isLike = initialIsLike;
          alldescription[index].isFavourite = initialIsFavourite;
          alldescription[index].likes = initialLikes;
          alldescription[index].favourite = initialFavourites;

        Get.snackbar(
          "Error",
          "Failed to save action. Received unexpected response from server.",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      // Revert to initial state on exception

        alldescription[index].isLike = initialIsLike;
        alldescription[index].isFavourite = initialIsFavourite;
        alldescription[index].likes = initialLikes;
        alldescription[index].favourite = initialFavourites;


      Get.snackbar(
        "Error",
        "Failed to save action: ${e.toString()}",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }




}
