import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:screenshot/screenshot.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mcq/models/hero/question.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/custom_spacer.dart';
import 'package:mcq/views/screens/hero/question/question_util.dart';
import 'package:mcq/views/screens/hero/question/question_view_model.dart';
import 'package:mcq/views/screens/question_report/question_report.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../helpers/preferences_helper.dart';
import '../../../../models/hero/alldescriptionresponse.dart';
import '../../../../models/hero/questionreportresponse.dart';
import '../../../../repository/hero_repository.dart';

import '../../question_screen/components/user_action_button.dart';
import '../question_type/question_type_view_model.dart';
import 'components/option_view.dart';

class QuestionScreen extends StatefulWidget {
  final QuestionViewModel vm;


  const QuestionScreen({super.key, required this.vm});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late QuestionViewModel vm;

  bool showDescription = false;
  //RxBool isDescription = false.obs;
  String? questionId;
  RxString selectedOption = 'A'.obs;
  //String? selectedOption;
  List<Question> question = [];
  String selectedLanguage = 'Hindi';

  bool showSpinner = false ;
  File? descriptionImage;
  late String appDocPath;
  final String typeId="";
  final String seriesIdId="";
  final String catId="";
  int currentQuestionId = 1; // Default starting question ID
  int currentCatId = 1; // Default starting question ID
  final heroRepository = Get.put(HeroRepository());
  final ImagePicker _picker = ImagePicker();
  ScreenshotController screenshotController = ScreenshotController();
  bool isSharing = false;
  final TextEditingController questionController = TextEditingController();
  var isLoading = false.obs;
  final QuestionTypeViewModel vms = Get.find<QuestionTypeViewModel>();
  @override
  void initState() {
    vm = widget.vm;

    super.initState();
    _textController = TextEditingController();
    _isTextNotEmpty = ValueNotifier<bool>(false);
    _textController.addListener(() {
      _isTextNotEmpty.value = _textController.text.isNotEmpty;
    });

    questionIdController.text = questionId ?? "1";


    init();
  }

  void toggleDescription() {

      showDescription = !showDescription;

  }

  void resetDescriptionVisibility() {
    setState(() {
      showDescription = false;
    });
  }
  late String token;
  late TextEditingController _textController;
  late ValueNotifier<bool> _isTextNotEmpty;
  final TextEditingController commentController = TextEditingController();
  final TextEditingController questionIdController = TextEditingController();
  final TextEditingController catIdController = TextEditingController();
  final TextEditingController typeIdController = TextEditingController();
  final TextEditingController seriesIdController = TextEditingController();
  final TextEditingController pageController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController problemController = TextEditingController();

  final TextEditingController descriptionIdController = TextEditingController();

  List<bool> isLiked = []; // State to track like status

  bool descriptionToggle = true;
  RxBool loading = true.obs;



  @override
  void dispose() {
    _textController.dispose();
    _isTextNotEmpty.dispose();
    super.dispose();
  }

  Future<void> init() async {
    token = await PreferenceHelper.getToken();
    if (token.isEmpty) {
      Get.snackbar(
        "Error",
        "Failed to retrieve authentication token.",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return;
    }






  }
  void isDescription(bool value) {
    setState(() {
      showDescription = value;
    });
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
      descriptionId: vm.alldescription[index].id!,
      questionId: vm.alldescription[index].questionId!,
      type: type,
      comment: comment,
    );

    // Initial state storage for rollback if needed
    bool initialIsLike = vm.alldescription[index].isLike ?? false;
    bool initialIsFavourite = vm.alldescription[index].isFavourite ?? false;
    int initialLikes = vm.alldescription[index].likes ?? 0;
    int initialFavourites = vm.alldescription[index].favourite ?? 0;

    // Optimistic UI update
    setState(() {
      if (type == 'like') {
        if (initialIsLike) {
          vm.alldescription[index].isLike = false;
          vm.alldescription[index].likes = initialLikes - 1;
        } else {
          vm.alldescription[index].isLike = true;
          vm.alldescription[index].likes = initialLikes + 1;
        }
      } else if (type == 'dislike') {
        if (initialIsLike) {
          vm.alldescription[index].isLike = false;
          vm.alldescription[index].likes = initialLikes - 1;
        }
        // Additional logic for dislikes if needed
      } else if (type == 'favourite') {
        if (initialIsFavourite) {
          vm.alldescription[index].isFavourite = false;
          vm.alldescription[index].favourite = initialFavourites - 1;
        } else {
          vm.alldescription[index].isFavourite = true;
          vm.alldescription[index].favourite = initialFavourites + 1;
        }
      } else if (type == 'unfavourite') {
        if (initialIsFavourite) {
          vm.alldescription[index].isFavourite = false;
          vm.alldescription[index].favourite = initialFavourites - 1;
        }
        // Additional logic for unfavouriting if needed
      }
    });

    try {
      var response = await heroRepository.postDescriptionLikes(body: request, token: token);

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
            setState(() {
              if (type == 'like' || type == 'dislike') {
                vm.alldescription[index].likes = (likesData is int) ? likesData : int.tryParse(likesData.toString()) ?? initialLikes;
              } else if (type == 'favourite' || type == 'unfavourite') {
                vm.alldescription[index].favourite = (favouritesData is int) ? favouritesData : int.tryParse(favouritesData.toString()) ?? initialFavourites;
              }
            });

            Get.snackbar(
              "Success",
              responseMessage,
              colorText: Colors.white,
              backgroundColor: Colors.green,
            );
          } else {
            // Revert to initial state on failure
            setState(() {
              vm.alldescription[index].isLike = initialIsLike;
              vm.alldescription[index].isFavourite = initialIsFavourite;
              vm.alldescription[index].likes = initialLikes;
              vm.alldescription[index].favourite = initialFavourites;
            });

            Get.snackbar(
              "Error",
              responseMessage,
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
          }
        } else {
          // Unexpected response format, revert to initial state
          setState(() {
            vm.alldescription[index].isLike = initialIsLike;
            vm.alldescription[index].isFavourite = initialIsFavourite;
            vm.alldescription[index].likes = initialLikes;
            vm.alldescription[index].favourite = initialFavourites;
          });
          Get.snackbar(
            "Error",
            "Failed to parse response. Received unexpected response format.",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } else {
        // Revert to initial state on server error
        setState(() {
          vm.alldescription[index].isLike = initialIsLike;
          vm.alldescription[index].isFavourite = initialIsFavourite;
          vm.alldescription[index].likes = initialLikes;
          vm.alldescription[index].favourite = initialFavourites;
        });
        Get.snackbar(
          "Error",
          "Failed to save action. Received unexpected response from server.",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      // Revert to initial state on exception
      setState(() {
        vm.alldescription[index].isLike = initialIsLike;
        vm.alldescription[index].isFavourite = initialIsFavourite;
        vm.alldescription[index].likes = initialLikes;
        vm.alldescription[index].favourite = initialFavourites;
      });

      Get.snackbar(
        "Error",
        "Failed to save action: ${e.toString()}",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }






  void showCommentSheet(BuildContext context, int index) {
    List<CommentUser> comments = vm.alldescription[index].commentUser ?? [];

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
                  comments.isEmpty
                      ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('No comments available.'),
                  )
                      : ListView.builder(
                    shrinkWrap: true,
                    itemCount: comments.length,
                    itemBuilder: (context, commentIndex) {
                      final comment = comments[commentIndex];
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
                                      child: comment.userData!.images != null &&
                                          comment.userData!.images!.isNotEmpty
                                          ? Image.network(
                                        comment.userData!.images!.toString(),
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
                                    Text(comment.userData!.name ?? "Unknown",style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                    ),),
                                    const SizedBox(width: 10,),
                                    Text(comment.createdAt ?? "Unknown time",


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
                                  Text(comment.comment ?? "",
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
                                id: (comments.length + 1), // Example ID
                                userId: 1, // Replace with actual user ID
                                questionId: vm.alldescription[index].questionId,
                                descriptionId: vm.alldescription[index].id,
                                comment: commentText,
                                createdAt: DateTime.now().toIso8601String(),
                                userData: UserData(
                                  name: "Your Name", // Replace with actual user data
                                  images: "assets/images/profile.png",
                                ),
                              );

                              // Create request body for saving comment
                              final request = constructRequestBody(
                                descriptionId: vm.alldescription[index].id!,
                                questionId: vm.alldescription[index].questionId!,
                                type: 'comment',
                                comment: commentText,
                              );

                              try {
                                var response = await heroRepository.postDescriptionLikes(body: request, token: token);

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
                                      setState(() {
                                        vm.alldescription[index].commentUser = (vm.alldescription[index].commentUser ?? [])..add(newComment);
                                      });

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

  void userReportBottomSheet(BuildContext context, int index) {
    // Controllers for the input fields
    final TextEditingController titleController = TextEditingController();
    final TextEditingController problemController = TextEditingController();

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
                    'Report Issue',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            hintText: 'Enter title',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: problemController,
                          decoration: const InputDecoration(
                            hintText: 'Describe the issue',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () async {
                            if (titleController.text.isNotEmpty && problemController.text.isNotEmpty) {
                              await submitUserReport(index, titleController.text, problemController.text);
                              Navigator.of(context).pop();
                            } else {
                              Get.snackbar(
                                "Error",
                                "All fields are required",
                                colorText: Colors.white,
                                backgroundColor: Colors.red,
                              );
                            }
                          },
                          child: const Text('Submit'),
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

  Future<void> submitUserReport(int index, String title, String problem) async {
    final isLoading = true.obs;

    final request = {
      'question_id': vm.alldescription[index].questionId.toString(),
      'description_id': vm.alldescription[index].id.toString(),
      //'comment_id': '', // Replace with actual comment ID if available
      'user_problem': problem,
      'title': title,
    };

    print("Request Data: $request");

    try {
      var response = await heroRepository.reportUser(
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

          if (nestedStatusCode == 201) {
            Get.snackbar(
              "Success",
              responseMessage,
              colorText: Colors.white,
              backgroundColor: Colors.green,
            );

            // Perform any additional actions needed after successful report
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
      } else {
        Get.snackbar(
          "Error",
          "Failed to save data. Received unexpected response from server.",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar(
        "Error",
        "Failed to submit report: ${e.toString()}",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }




  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        descriptionImage = File(pickedFile.path);
      });
    } else {
      print('No image selected');
    }
  }

  void updateDescriptionBottomSheet(BuildContext context, int index) {
    const String currentUserId = 'user_id';

    // Debug: Print user IDs for comparison
    print("Current User ID: $currentUserId");
    print("Description User ID: ${vm.alldescription[index].userId}");

    final TextEditingController descriptionController = TextEditingController(text: vm.alldescription[index].description ?? "");
    File? selectedImage;

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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Update Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    maxLines: 5,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        selectedImage = File(image.path);
                        // Display image name or some identifier
                        Get.snackbar(
                          "Image Selected",
                          "Image: ${image.name}",
                          colorText: Colors.white,
                          backgroundColor: Colors.green,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                    child: const Text('Select Image'),
                  ),
                  const SizedBox(height: 10),
                  if (selectedImage != null)
                    Text(
                      "Image Selected: ${selectedImage!.path.split('/').last}",
                      style: const TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (descriptionController.text.isNotEmpty) {
                            String? base64Image;
                            if (selectedImage != null) {
                              List<int> imageBytes = await selectedImage!.readAsBytes();
                              base64Image = base64Encode(imageBytes);
                            }

                            // Call the updateDescription method with the image file
                            await updateDescription(index, descriptionController.text, selectedImage);

                            Navigator.of(context).pop();
                          } else {
                            Get.snackbar(
                              "Error",
                              "Description cannot be empty",
                              colorText: Colors.white,
                              backgroundColor: Colors.red,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        ),
                        child: isLoading(false)
                            ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                            : const Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  void reportQuestionBottomSheet(Question question) async {
    File? selectedImage;

    TextEditingController questionController = TextEditingController(text: vms.selectedLanguage == "Hindi"?question.questionHi:question.question);

    List<TextEditingController> optionControllers = [
      TextEditingController(text: vms.selectedLanguage == "Hindi"?question.options1Hi:question.options1),
      TextEditingController(text: vms.selectedLanguage == "Hindi"?question.options2Hi:question.options2),
      TextEditingController(text: vms.selectedLanguage == "Hindi"?question.options3Hi:question.options3),
      TextEditingController(text: vms.selectedLanguage == "Hindi"?question.options4Hi:question.options4),
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
                                setState(() {
                                  isLoading(true);
                                });


                                final update = await heroRepository.sendQuestionReport(
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
                                setState(() {
                                  isLoading( false);
                                });
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

  Future<bool> sendQuestionReport({
    required String questionId,
    required String questionLanguage,
    required String reportQuestion,
    required String reportOptionA,
    required String reportOptionB,
    required String reportOptionC,
    required String reportOptionD,
    required String userNote,
     String? reportDescripton,
    required String reportCorrectAnswer,
  }) async {
    final Uri url = Uri.parse('https://examopd.com/api/v1/QuestionReport');
    final Map<String, dynamic> requestBody = {
      'question_id': questionId,
      'question_language': questionLanguage,
      'report_question': reportQuestion,
      'report_option_a': reportOptionA,
      'report_option_b': reportOptionB,
      'report_option_c': reportOptionC,
      'report_option_d': reportOptionD,
      'user_notes': userNote,
      'report_description': reportDescripton,
      'report_correct_answer': reportCorrectAnswer,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      print('Request Body: ${jsonEncode(requestBody)}'); // Debugging line
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}'); // Debugging line

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final questionReportResponse = QuestionResportResponse.fromJson(responseData);

        // Handle successful response if needed
        return questionReportResponse.statusCode == 200;
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error sending data: $e');
      return false; // Error occurred
    }
  }







  Future<void> updateDescription(int index, String description, File? selectedImage) async {
    setState(() {
      isLoading(true);
    });

    try {
      var uri = Uri.parse('https://examopd.com/api/v1/update-description?id=${vm.alldescription[index].id}');
      var requestMultipart = http.MultipartRequest('POST', uri);
      requestMultipart.headers['Authorization'] = 'Bearer your_actual_token'; // Replace with your actual token
      requestMultipart.fields['description'] = description;
      requestMultipart.fields['question_id'] = vm.alldescription[index].questionId.toString();
      requestMultipart.fields['user_id'] = vm.alldescription[index].userId.toString();

      if (selectedImage != null) {
        var stream = http.ByteStream(selectedImage.openRead());
        var length = await selectedImage.length();
        var multipartFile = http.MultipartFile(
          'image',
          stream,
          length,
          filename: selectedImage.path.split('/').last,
        );

        requestMultipart.files.add(multipartFile);
      }

      var response = await requestMultipart.send();
      var responseString = await response.stream.bytesToString();
      var responseBody = jsonDecode(responseString);

      if (response.statusCode == 200) {
        final responseMessage = responseBody['responseMessage'] ?? "Unknown error occurred";

        Get.snackbar(
          "Success",
          responseMessage,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );

        // Fetch updated descriptions for the current question ID
        await vm.getDescriptions(vm.alldescription[index].questionId.toString());

        setState(() {
          // Optionally clear the state or UI
        });
      } else {
        Get.snackbar(
          "Error",
          responseBody['responseMessage'] ?? "Failed to update data.",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update description: ${e.toString()}",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } finally {
      setState(() {
        isLoading (false);
      });
    }
  }


  Future<void> toggleLike(int index) async {
    final isCurrentlyLiked = vm.alldescription[index].isLike ?? false;
    final actionType = isCurrentlyLiked ? 'dislike' : 'like';

    // Optimistically update the UI
    setState(() {
      vm.alldescription[index].isLike = !isCurrentlyLiked;
      if (isCurrentlyLiked) {
        vm.alldescription[index].likes = (vm.alldescription[index].likes ?? 0) - 1;
      } else {
        vm.alldescription[index].likes = (vm.alldescription[index].likes ?? 0) + 1;
      }
    });

    final request = {
      'description_id': vm.alldescription[index].id.toString(),
      'question_id': vm.alldescription[index].questionId.toString(),
      'type': actionType,
    };

    try {
      var response = await heroRepository.postDescriptionLikes(body: request, token: token);

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
            setState(() {
              vm.alldescription[index].likes = (likesData is int)
                  ? likesData
                  : int.tryParse(likesData.toString()) ?? (vm.alldescription[index].likes ?? 0);
            });

            print("LIked");

           /* Get.snackbar(
              "Success",
              responseMessage,
              colorText: Colors.white,
              backgroundColor: Colors.green,
            );*/
          } else {
            // Revert the optimistic UI update on failure
            setState(() {
              vm.alldescription[index].isLike = isCurrentlyLiked;
              vm.alldescription[index].likes = isCurrentlyLiked
                  ? (vm.alldescription[index].likes ?? 0) + 1
                  : (vm.alldescription[index].likes ?? 0) - 1;
            });

            Get.snackbar(
              "Error",
              responseMessage,
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
          }
        } else {
          // Revert the optimistic UI update on unexpected response format
          setState(() {
            vm.alldescription[index].isLike = isCurrentlyLiked;
            vm.alldescription[index].likes = isCurrentlyLiked
                ? (vm.alldescription[index].likes ?? 0) + 1
                : (vm.alldescription[index].likes ?? 0) - 1;
          });
          Get.snackbar(
            "Error",
            "Failed to parse response. Received unexpected response format.",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } else {
        // Revert the optimistic UI update on server error
        setState(() {
          vm.alldescription[index].isLike = isCurrentlyLiked;
          vm.alldescription[index].likes = isCurrentlyLiked
              ? (vm.alldescription[index].likes ?? 0) + 1
              : (vm.alldescription[index].likes ?? 0) - 1;
        });
        Get.snackbar(
          "Error",
          "Failed to save action. Received unexpected response from server.",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      // Revert the optimistic UI update on exception
      setState(() {
        vm.alldescription[index].isLike = isCurrentlyLiked;
        vm.alldescription[index].likes = isCurrentlyLiked
            ? (vm.alldescription[index].likes ?? 0) + 1
            : (vm.alldescription[index].likes ?? 0) - 1;
      });

      Get.snackbar(
        "Error",
        "Failed to save action: ${e.toString()}",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> toggleFavourite(int index) async {
    final isCurrentlyFavourite = vm.alldescription[index].isFavourite ?? false;
    final actionType = isCurrentlyFavourite ? 'unfavourite' : 'favourite';

    // Optimistically update the UI
    setState(() {
      vm.alldescription[index].isFavourite = !isCurrentlyFavourite;
      if (isCurrentlyFavourite) {
        vm.alldescription[index].favourite = (vm.alldescription[index].favourite ?? 0) - 1;
      } else {
        vm.alldescription[index].favourite = (vm.alldescription[index].favourite ?? 0) + 1;
      }
    });

    final request = {
      'description_id': vm.alldescription[index].id.toString(),
      'question_id': vm.alldescription[index].questionId.toString(),
      'type': actionType,
    };

    try {
      var response = await heroRepository.postDescriptionLikes(body: request, token: token);

      if (response is Map<String, dynamic> &&
          response.containsKey('statusCode') &&
          response.containsKey('responseBody')) {
        final responseBody = response['responseBody'];

        if (responseBody is String) {
          final parsedResponseBody = json.decode(responseBody) as Map<String, dynamic>;
          final nestedStatusCode = parsedResponseBody['statusCode'];
          final responseMessage = parsedResponseBody['responseMessage'] ?? "Unknown error";
          final favouritesData = parsedResponseBody['data']['favourites'];

          if (nestedStatusCode == 201) {
            setState(() {
              vm.alldescription[index].favourite = (favouritesData is int)
                  ? favouritesData
                  : int.tryParse(favouritesData.toString()) ?? (vm.alldescription[index].favourite ?? 0);
            });
print("success");
            /*Get.snackbar(
              "Success",
              responseMessage,
              colorText: Colors.white,
              backgroundColor: Colors.green,
            );*/
          } else {
            // Revert the optimistic UI update on failure
            setState(() {
              vm.alldescription[index].isFavourite = isCurrentlyFavourite;
              vm.alldescription[index].favourite = isCurrentlyFavourite
                  ? (vm.alldescription[index].favourite ?? 0) + 1
                  : (vm.alldescription[index].favourite ?? 0) - 1;
            });

            Get.snackbar(
              "Error",
              responseMessage,
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
          }
        } else {
          // Revert the optimistic UI update on unexpected response format
          setState(() {
            vm.alldescription[index].isFavourite = isCurrentlyFavourite;
            vm.alldescription[index].favourite = isCurrentlyFavourite
                ? (vm.alldescription[index].favourite ?? 0) + 1
                : (vm.alldescription[index].favourite ?? 0) - 1;
          });
          Get.snackbar(
            "Error",
            "Failed to parse response. Received unexpected response format.",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } else {
        // Revert the optimistic UI update on server error
        setState(() {
          vm.alldescription[index].isFavourite = isCurrentlyFavourite;
          vm.alldescription[index].favourite = isCurrentlyFavourite
              ? (vm.alldescription[index].favourite ?? 0) + 1
              : (vm.alldescription[index].favourite ?? 0) - 1;
        });
        Get.snackbar(
          "Error",
          "Failed to save action. Received unexpected response from server.",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      // Revert the optimistic UI update on exception
      setState(() {
        vm.alldescription[index].isFavourite = isCurrentlyFavourite;
        vm.alldescription[index].favourite = isCurrentlyFavourite
            ? (vm.alldescription[index].favourite ?? 0) + 1
            : (vm.alldescription[index].favourite ?? 0) - 1;
      });

      Get.snackbar(
        "Error",
        "Failed to save action: ${e.toString()}",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }






  Future<void> submitReport() async {
    const String reportUrl = 'https://examopd.com/api/v1/QuestionReport'; // Replace with your actual report URL
    final Map<String, String> reportData = {
      'questionId': vm.currentQuestion.value?.id.toString() ?? '',
      'reportDescription': problemController.text,
      'userNotes': commentController.text,
    };

    final request = http.MultipartRequest('POST', Uri.parse(reportUrl))
      ..fields.addAll(reportData);

    if (descriptionImage != null) {
      final fileStream = http.ByteStream(descriptionImage!.openRead());
      final fileLength = await descriptionImage!.length();

      final multipartFile = http.MultipartFile(
        'userImageVideo',
        fileStream,
        fileLength,
        filename: descriptionImage!.path.split('/').last,
      );

      request.files.add(multipartFile);
    }

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        // Handle the response as needed
        print('Report submitted successfully: $responseBody');
      } else {
        // Handle the error response
        print('Failed to submit report: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Handle the exception
      print('Error submitting report: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Obx(
          () => vm.loading.value
          ? SizedBox(
        height: Get.height - 500,
        child: const Center(
          child: Text("Please Wait.."),
        ),
      )
          : Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Bar
          Container(
            color: Colors.blue, // Replace with your primary color
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Status
                Obx(() => circleText(vm.questionSeries.value.toString())),
                line(),
                Obx(() => circleText(vm.questionFlag.value)),

                // Access icon
                const Icon(Icons.access_alarm, color: Colors.white),

                // Time Text
                const SizedBox(width: 5),
                Obx(
                      () => Text(
                    vm.timeText.value,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),

                // Bookmark question

                Expanded(child: Container()),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.star_border,
                    color: Colors.white,
                  ),
                ),



                // Question report
                IconButton(
                  onPressed: () {
                    reportQuestionBottomSheet(vm.currentQuestion.value!);
                  },
                  icon: const Icon(
                    Icons.report_problem_outlined,
                    color: Colors.white,
                  ),
                ),

                // Share question
                IconButton(
                  onPressed: () async {
                    setState(() {
                      isSharing = true;
                    });
                    try {
                      // Capture the screenshot as a byte array
                      final imageFile = await screenshotController.capture();

                      if (imageFile != null) {
                        // Get the application's documents directory
                        final directory = await getApplicationDocumentsDirectory();

                        // Define the image file path
                        final imagePath = '${directory.path}/question.png';

                        // Save the image as a file
                        final file = File(imagePath);
                        await file.writeAsBytes(imageFile);

                        // Share the image file
                        await Share.shareFiles([imagePath], text: 'Check out this question!');
                      }
                    } catch (e) {
                      print('Error sharing screenshot: $e');
                    } finally {
                      setState(() {
                        isSharing = false;
                      });
                    }
                  },
                  icon: const FaIcon(
                    Icons.share_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                      () => vm.currentQuestion.value == null
                      ? Container()
                      : SizedBox(
                    height: Get.height * .66,
                    child: Screenshot(
                      controller: screenshotController,
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.white,
                            child: questionItemBuilder(
                                vm.currentQuestion.value!),
                          ),
                          if (isSharing)
                            Center(
                              child: Opacity(
                                opacity: 0.5, // Adjust the opacity as needed
                                child: Image.asset(
                                  'assets/images/app_logo.png', // Replace with your logo asset path
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (vm.currentQuestion.value != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Obx(
                              () => CustomButton(
                            title: "Previous",
                            height: 40,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            onPressed: vm.isShowPreviousButton.value
                                ? () {
                              // Navigate to previous question
                              isDescription(true);

                              vm.previousPage();
                              // Add your logic here
                            }
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Obx(
                              () => CustomButton(
                            title: "Next",
                            height: 40,
                            onPressed: vm.isShowNextButton.value
                                ? () {
                             isDescription(false);
                              vm.nextPage();

                            }
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget questionItemBuilder(Question question) {
    final selectedLanguage = Get.find<QuestionTypeViewModel>().selectedLanguage;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hSpacer(5),
          Html(
            data: """<div style="font-size: 20px;">
            ${selectedLanguage == 'Hindi' ? question.questionHi : question.question ?? "Question"}</div>""",
          ),
          hSpacer(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Text(question.ename.toString(), style: const TextStyle(
                fontSize: 10, color: Colors.black87
              ),)
            ],
          ),
          hSpacer(5),
          optionView(
            question: question,
            onTap: ({
              required bool hasEnableOption,
              required OptionFlag optionFlag,
            }) {

              vm.onTapOption(
                  hasEnableOption: hasEnableOption, optionFlag: optionFlag);
              setState(() {
                vm.submitUserAnswer(question.id.toString(),question.categId.toString(),question.selectedOptionByUser.toString(),question.chapter.toString(),);
                print("User ans: ${question.data!.userAns}");
                vm.getDescriptions(question.id.toString());
                toggleDescription();
              });

            },
            onTapEnableButton: ({
              required bool hasEnableOption,
              required OptionFlag optionFlag,
            }) {
              vm.onTapEnableButton(
                  hasEnableOption: hasEnableOption, optionFlag: optionFlag);
              setState(() {
                vm.getDescriptions(question.id.toString());
                toggleDescription();
              });
            },
          ),
          hSpacer(10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8)),
            child: Text("${question.totalQuestionAnsForPoll} Answers"),
          ),
          hSpacer(20),
          if (showDescription)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: showDescription,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.primaryColor.withOpacity(0.1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Description",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        descriptionToggle = !descriptionToggle;
                                      });
                                    },
                                    icon: Icon(
                                        descriptionToggle
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Flexible(
                                    child: TextField(
                                      controller: _textController,
                                      onChanged: (text) {
                                        _isTextNotEmpty.value = text.isNotEmpty;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                        hintText: "Enter text here...",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    icon: const Icon(Icons.attach_file),
                                    onPressed: () async {
                                      pickImage();

                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  ValueListenableBuilder<bool>(
                                    valueListenable: _isTextNotEmpty,
                                    builder: (context, isNotEmpty, child) {
                                      return isNotEmpty
                                          ? Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(Icons.send, color: Colors.white),
                                          onPressed:()async{
                                            if (question.id!=null) {
                                              await vm.getDescriptions(question.id.toString());
                                            } else {
                                              print("Question is null");
                                            }

                                            await vm.saveData(question);
                                          },
                                        ),
                                      )
                                          : const SizedBox.shrink();
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Display the solution text for the selected question
                      question.questionno!.isNotEmpty?
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.primaryColor.withOpacity(0.1),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      question.solutionHi.toString(),
                                      maxLines: 4,

                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      )
                          :const SizedBox.shrink(),
                      const SizedBox(height: 10),
                      Obx(
                          ()=>ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: vm.alldescription.length,
                            itemBuilder: (context, index) {
                              final description = vm.alldescription[index];
                              final isLiked = description.isLike ?? false;
                              final descriptionFav = vm.alldescription[index];
                              final isFavourite = description.isFavourite ?? false;

                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColors.primaryColor.withOpacity(0.1),
                                  ),
                                  child: Visibility(
                                    visible: descriptionToggle,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: Colors.transparent,
                                                    child: SizedBox(
                                                      width: 60,
                                                      height: 60,
                                                      child: ClipOval(
                                                        child: description.userImage != null && description.userImage!.isNotEmpty
                                                            ? Image.network(description.userImage!)
                                                            : Image.asset("assets/images/profile.png"),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          vm.alldescription[index].userName ?? "",
                                                          style: TextStyle(
                                                              color: Colors.black.withOpacity(0.5),
                                                              fontSize: 19,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                        Text(
                                                          vm.alldescription[index].time.toString(),
                                                          style: TextStyle(
                                                            color: Colors.black.withOpacity(0.5),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  UserActionButton(
                                                    iconData: isFavourite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                                                    color: isFavourite ? Colors.cyan : Colors.cyan,
                                                    value: descriptionFav.favourite.toString(),
                                                    onTap: () async {
                                                      await toggleFavourite(index);
                                                    },
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                vm.alldescription[index].description ?? "",
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              // Display the image if available
                                              if (vm.alldescription[index].image != null && vm.alldescription[index].image!.isNotEmpty)
                                                SizedBox(
                                                  width: 200,
                                                  height: 400,
                                                  child: Image.network(
                                                    vm.alldescription[index].image!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              else
                                                const SizedBox.shrink(),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          color: Colors.grey,
                                          width: double.infinity,
                                          height: 1,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 10),
                                              UserActionButton(
                                                iconData: isLiked ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
                                                color: isLiked ? Colors.blue : Colors.grey,
                                                value: vm.alldescription[index].likes.toString(),
                                                onTap: () async {
                                                  toggleLike(index);
                                                },
                                              ),
                                              const SizedBox(width: 10),
                                              UserActionButton(
                                                iconData: FontAwesomeIcons.comment,
                                                color: Colors.lightBlue,
                                                value: vm.alldescription[index].commentUser!.length.toString(),
                                                onTap: () {
                                                  showCommentSheet(context, index);
                                                },
                                              ),
                                              const SizedBox(width: 10),
                                              UserActionButton(
                                                iconData: FontAwesomeIcons.solidShareFromSquare,
                                                color: Colors.lightBlue,
                                                value: vm.alldescription[index].share.toString(),
                                                onTap: () async {
                                                  //await handleAction(index: index, type: 'share');
                                                },
                                              ),
                                              const Spacer(),
                                              PopupMenuButton<String>(
                                                icon: const Icon(
                                                  Icons.more_vert,
                                                  color: Colors.black54,
                                                ),
                                                onSelected: (String value) {
                                                  switch (value) {
                                                    case 'Report':
                                                      userReportBottomSheet(context, index);
                                                      break;
                                                    case 'Edit':
                                                      updateDescriptionBottomSheet(context, index);
                                                      break;
                                                    case 'Delete':
                                                    //handleDeleteAction(index);
                                                      break;
                                                  }
                                                },
                                                itemBuilder: (BuildContext context) {
                                                  return {'Report', 'Edit', 'Delete'}.map((String choice) {
                                                    return PopupMenuItem<String>(
                                                      value: choice,
                                                      child: Text(choice),
                                                    );
                                                  }).toList();
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
                          )
                      ),








                    ],
                  ),
                ),
              ],
            ),
          const SizedBox(height: 50,)
        ],
      ),
    );
  }


  Widget circleText(text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: Container(
        alignment: Alignment.center,
        height: 3.5.h,
        width: 3.5.h,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(60)),
        child: Text(
          text,
          style: TextStyle(color: AppColors.primaryColor, fontSize: 2.h),
        ),
      ),
    );
  }

  Widget line() => Container(color: Colors.white, width: 1, height: 20);
}
