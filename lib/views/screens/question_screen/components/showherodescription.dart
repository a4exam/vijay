/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/color.dart';

import 'package:mcq/views/screens/question_screen/components/user_action_button.dart';

import '../../../../helpers/preferences_helper.dart';
import '../../../../models/hero/alldescriptionresponse.dart';

import '../../../../models/hero/question.dart';
import '../../../../repository/hero_repository.dart';


class ShowDescription extends StatefulWidget {
  final String? questionId;
  final String? descriptionDetails;
  final bool? isDescription;
  final double? zoomScale;
  final String? typeId;
  final String? seriesId;
  final String? page;
  final String? catId;
  final String? descriptionId;
  final String? type;

  const ShowDescription({
    super.key,
    this.questionId,
    this.descriptionDetails,
    this.isDescription,
    this.zoomScale,
    this.typeId,
    this.seriesId,
    this.descriptionId,
    this.page,
    this.catId,
    this.type,
  });

  @override
  State<ShowDescription> createState() => _ShowDescriptionState();
}

class _ShowDescriptionState extends State<ShowDescription> {
  final heroRepository = Get.put(HeroRepository());
  late String token;
  late TextEditingController _textController;
  late ValueNotifier<bool> _isTextNotEmpty;
  final TextEditingController commentController = TextEditingController();
  final TextEditingController questionIdController = TextEditingController();
  final TextEditingController descriptionIdController = TextEditingController();
  List<AllDescriptionData> alldescription = [];
  List<bool> isLiked = []; // State to track like status
  List<Question> question = [];
  bool descriptionToggle = true;
  RxBool loading = true.obs;
  AllDescriptionData vms = AllDescriptionData();
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _isTextNotEmpty = ValueNotifier<bool>(false);
    _textController.addListener(() {
      _isTextNotEmpty.value = _textController.text.isNotEmpty;
    });

    questionIdController.text = widget.questionId ?? "1";

    init(); // Call the init method
  }

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


    await getDescriptions(questionIdController.text);

    String typeId = widget.typeId ?? "69";
    String seriesId = widget.seriesId ?? "1";
    String page = widget.page ?? "1";

    await getQuestion(seriesId: seriesId, typeId: typeId, page: page);
  }

  Map<String, dynamic> constructRequestBody({
    required int descriptionId,
    required int questionId,
    required String type,
    String? comment,
  }) {
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


  Future<void> handleAction({
    required int index,
    required String type,
    String? comment,
  }) async {
    final request = constructRequestBody(
      descriptionId: alldescription[index].id!,
      questionId: alldescription[index].questionId!,
      type: type,
      comment: comment,
    );

    // Optimistically update the UI based on the type of action
    setState(() {
      if (type == 'like' || type == 'dislike') {
        alldescription[index].isLike = !alldescription[index].isLike!;
        alldescription[index].likes = (alldescription[index].likes ?? 0) + (alldescription[index].isLike! ? 1 : -1);
      } else if (type == 'favourite') {
        alldescription[index].isFavourite = !alldescription[index].isFavourite!;
        alldescription[index].favourite = (alldescription[index].favourite ?? 0) + (alldescription[index].isFavourite! ? 1 : -1);
      } else if (type == 'share') {
        // Handle UI updates for share action if needed
      } else if (type == 'comment') {
        // Handle UI updates for comment action if needed
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
                alldescription[index].likes = (likesData is int) ? likesData : int.tryParse(likesData.toString()) ?? (alldescription[index].likes ?? 0);
              } else if (type == 'favourite') {
                alldescription[index].favourite = (favouritesData is int) ? favouritesData : int.tryParse(favouritesData.toString()) ?? (alldescription[index].favourite ?? 0);
              }
            });

            Get.snackbar(
              "Success",
              responseMessage,
              colorText: Colors.white,
              backgroundColor: Colors.green,
            );
          } else {
            // Revert the optimistic UI update on failure
            setState(() {
              if (type == 'like' || type == 'dislike') {
                alldescription[index].isLike = !alldescription[index].isLike!;
                alldescription[index].likes = (alldescription[index].likes ?? 0) + (alldescription[index].isLike! ? 1 : -1);
              } else if (type == 'favourite') {
                alldescription[index].isFavourite = !alldescription[index].isFavourite!;
                alldescription[index].favourite = (alldescription[index].favourite ?? 0) + (alldescription[index].isFavourite! ? 1 : -1);
              }
            });

            Get.snackbar(
              "Error",
              responseMessage,
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
          }
        } else {
          // Revert the optimistic UI update on failure
          setState(() {
            if (type == 'like' || type == 'dislike') {
              alldescription[index].isLike = !alldescription[index].isLike!;
              alldescription[index].likes = (alldescription[index].likes ?? 0) + (alldescription[index].isLike! ? 1 : -1);
            } else if (type == 'favourite') {
              alldescription[index].isFavourite = !alldescription[index].isFavourite!;
              alldescription[index].favourite = (alldescription[index].favourite ?? 0) + (alldescription[index].isFavourite! ? 1 : -1);
            }
          });

          Get.snackbar(
            "Error",
            "Failed to parse response. Received unexpected response format.",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } else {
        // Revert the optimistic UI update on failure
        setState(() {
          if (type == 'like' || type == 'dislike') {
            alldescription[index].isLike = !alldescription[index].isLike!;
            alldescription[index].likes = (alldescription[index].likes ?? 0) + (alldescription[index].isLike! ? 1 : -1);
          } else if (type == 'favourite') {
            alldescription[index].isFavourite = !alldescription[index].isFavourite!;
            alldescription[index].favourite = (alldescription[index].favourite ?? 0) + (alldescription[index].isFavourite! ? 1 : -1);
          }
        });

        Get.snackbar(
          "Error",
          "Failed to save action. Received unexpected response from server.",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      // Revert the optimistic UI update on failure
      setState(() {
        if (type == 'like') {
          alldescription[index].isLike= !alldescription[index].isLike!;
          alldescription[index].likes = (alldescription[index].likes ?? 0) + (alldescription[index].isLike! ? 1 : -1);
        } else if (type == 'favourite') {
          alldescription[index].isFavourite = !alldescription[index].isFavourite!;
          alldescription[index].favourite = (alldescription[index].favourite ?? 0) + (alldescription[index].isFavourite! ? 1 : -1);
        }
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
    List<CommentUser> comments = alldescription[index].commentUser ?? [];

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
                    : Expanded(
                  child: ListView.builder(
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
                                      child: comment.userData?.images != null &&
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
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
                                      alldescription[index].commentUser = (alldescription[index].commentUser ?? [])..add(newComment);
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
        );
      },
    );
  }






  Future<void> getDescriptions(String questionId) async {
    loading(true);

    try {
      final response = await heroRepository.getDescription(
        token: token,
        questionId: questionId,
      );

      setState(() {
        alldescription = response;
        isLiked = response.map<bool>((desc) => desc.likeUser == 'true').toList();
      });
    } catch (e) {
      print("Error fetching descriptions: $e");
    } finally {
      loading(false);
    }
  }



  Future<void> getQuestion({required String seriesId, required String typeId, required String page,}) async {
    loading(true);

    try {
      final response = await heroRepository.getQuestions(
        token: token,
        seriesId: seriesId,
        typeId: typeId,
        page: page,
      );

      if (response.isNotEmpty) {
        setState(() {
          question = response;
        });
      } else {
        setState(() {
          question = [];
        });
      }
    } catch (e) {
      print("Error fetching questions: $e");
      setState(() {
        question = [];
      });
    } finally {
      loading(false);
    }
  }






  Future<void> saveData() async {
    loading(true);

    String questionId = questionIdController.text.trim()??"1";
    String catId = widget.catId ?? "1"; // Use a meaningful default value if catId is null

    if (questionId.isEmpty) {
      Get.snackbar(
        "Error",
        "Question ID cannot be empty.",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      loading(false);
      return;
    }

    final request = {
      'description': _textController.text,
      'question_id': questionId,
      'cat_id': catId, // Ensure catId is included in the request
    };

    print("Request Data: $request"); // Debugging statement to check the request payload

    try {
      var response = await heroRepository.postDescription(
        body: request, token: token,
      );

      loading(false);

      // Log the exact response
      print("Raw Response: $response");

      // Check if the response is in JSON format
      if (response is Map<String, dynamic> && response.containsKey('statusCode') && response.containsKey('responseBody')) {
        final statusCode = response['statusCode'];
        final responseBody = response['responseBody'];

        // Ensure responseBody is a String and parse it as JSON
        if (responseBody is String) {
          final parsedResponseBody = json.decode(responseBody);

          // Extract nested response fields
          final responseMessage = parsedResponseBody['responseMessage'] ?? "Unknown error occurred"; // Default message if responseMessage is null
          final nestedStatusCode = parsedResponseBody['statusCode'];

          print("Response Status: $statusCode");
          print("Response Message: $responseMessage");

          if (nestedStatusCode == 201) {
            Get.snackbar(
              "Success",
              responseMessage,
              colorText: Colors.white,
              backgroundColor: Colors.green,
            );

            await getDescriptions(questionId); // Make sure getDescriptions uses the correct catId
            await getQuestion(
              seriesId: widget.seriesId ?? "1",
              typeId: widget.typeId ?? "69", page: '1',
            );
            setState(() {
              _textController.clear(); // Optionally clear text field
            });
          } else {
            print("Failed to save data: $responseMessage");
            Get.snackbar(
              "Error",
              responseMessage,
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
          }
        } else {
          // Handle unexpected responseBody type
          print("Unexpected responseBody type: $responseBody");
          Get.snackbar(
            "Error",
            "Failed to save data. Received unexpected response from server.",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } else {
        // Handle non-JSON response (e.g., HTML)
        print("Non-JSON response: $response");
        Get.snackbar(
          "Error",
          "Failed to save data. Received unexpected response from server.",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print("Error saving data: $e");
      loading(false);
      Get.snackbar(
        "Error",
        "Failed to save data: ${e.toString()}",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // Find the question with the matching ID, or provide a default empty question


    return Visibility(
      visible: widget.isDescription ?? false,
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
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30))),
                            hintText: "Enter text here...",
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      ValueListenableBuilder<bool>(
                        valueListenable: _isTextNotEmpty,
                        builder: (context, isNotEmpty, child) {
                          return isNotEmpty
                              ? Container(
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.send, color: Colors.white,),
                              onPressed: () {
                                saveData();
                              },
                            ),
                          )
                              : const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Display the solution text for the selected question
          question.isNotEmpty?Container(
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
                      Text(
                        question[0].solutionHi.toString(),
                      ),
                    ],
                  ),

                // Debug print for the solution

              ],
            ),
          ):const SizedBox.shrink(),
          const SizedBox(height: 10),
          Obx(() {
            if (loading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (alldescription.isEmpty) {
              return const Center(child: Text("No descriptions available."));
            } else {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: alldescription.length,
                itemBuilder: (context, index) {
                  // Debug print for each item in ListView.builder
                  print("Index: $index, Description: ${alldescription[index].description}");

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
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
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
                                            child: alldescription[index].userImage != null && alldescription[index].userImage!.isNotEmpty
                                                ? Image.network(
                                              alldescription[index].userImage!.toString(),
                                            )
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
                                              alldescription[index].userName ?? "",
                                              style: TextStyle(
                                                  color: Colors.black.withOpacity(0.5),
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              alldescription[index].time.toString(),
                                              style: TextStyle(
                                                color: Colors.black.withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      UserActionButton(
                                        iconData: alldescription[index].isFavourite! ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                                        color: alldescription[index].isFavourite! ? Colors.cyan : Colors.cyan,
                                        value: alldescription[index].favourite.toString(),
                                        onTap: () async {
                                          await handleAction(index: index, type: 'favourite');
                                        },
                                      ),

                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 50.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          alldescription[index].description ?? "",
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.grey,
                              width: size.width,
                              height: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),

                                  UserActionButton(
                                    iconData: isLiked[index] ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
                                    color: Colors.cyan,
                                    value: alldescription[index].likes.toString(),
                                    onTap: () async {
                                      await handleAction(index: index, type: isLiked[index] ? 'dislike' : 'like');
                                    },
                                  ),

                                  const SizedBox(width: 10),
                                  UserActionButton(
                                    iconData: FontAwesomeIcons.comment,
                                    color: Colors.lightBlue,
                                    value: alldescription[index].commentUser!.length.toString(),
                                    onTap: () {

                                    showCommentSheet(context, index);

                                  },
                                  ),
                                  const SizedBox(width: 10),
                                  UserActionButton(
                                    iconData: FontAwesomeIcons.solidShareFromSquare,
                                    color: Colors.lightBlue,
                                    value: alldescription[index].share.toString(),
                                    onTap: () async {
                                      await handleAction(index: index, type: 'share');
                                    },
                                  ),
                                  const Spacer(),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 8,
                                        ),
                                        child: Icon(
                                          Icons.more_vert,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
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
          }),
        ],
      ),
    );
  }
}*/
