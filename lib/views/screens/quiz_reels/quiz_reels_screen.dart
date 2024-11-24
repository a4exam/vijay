import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/utils/question_list.dart';
import 'package:mcq/views/screens/quiz_reels/quiz_reels_view_model.dart';
import 'package:mcq/views/screens/quiz_reels/quizreeloption.dart';
import '../../../models/quizReel/quizreelresponse.dart';
import '../question_screen/components/user_action_button.dart';

class QuizReelsPage extends StatefulWidget {
  final bool isFromHome;

  const QuizReelsPage({super.key, required this.isFromHome});

  @override
  State<QuizReelsPage> createState() => _QuizReelsPageState();
}

class _QuizReelsPageState extends State<QuizReelsPage> {
  final vm = Get.put(QuizReelsViewModel());

  void _handleOptionSelect(int questionIndex, int optionIndex, QuizReelData question) {
    // Only allow selection if no option has been selected yet for this question
    if (vm.optionSelections[questionIndex] == null) {
      setState(() {
        vm.optionSelections[questionIndex] = optionIndex;
      });
    }
  }

  @override
  void initState() {
    super.initState();

  }

  Future<void> onNextButtonPressed() async {
    await vm.fetchQuizData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text("Quiz Reel"),
        actions: [
          IconButton(
            onPressed: vm.toggleLanguage,
            icon: const Icon(Icons.translate),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: (){
               vm.onNavigateToPrevious();
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor,
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Previous',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {

                vm.onNavigateToNext();
                vm.timeText.value="00:00";
              },

              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor,
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Obx(() {
      if (vm.isLoading.value) {
        return Center(child: CircularProgressIndicator()); // Show loader when fetching data
      }

      if (vm.quizData.isEmpty) {
        return Center(child: Text('No quiz data available'));


      }

       vm.selectedOptionIndex.value = vm.optionSelections[vm.currentPageIndex.value];// Get current quiz data based on index
            return SingleChildScrollView(
              child: Column(
                children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Obx(
                                 () => Row(
                               children: [
                                 const SizedBox(width: 10,),
                                 const Icon(Icons.access_alarm, color: Colors.black),
                                 Text(vm.timeText.value, style: const TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 20,
                                     color: Colors.black),
                                 ),
                               ],
                             ),
                           ),
                           Row(
                                           mainAxisAlignment: MainAxisAlignment.end,
                                           children: [


                                             IconButton(
                                               icon: const Icon(Icons.star_border),
                                               onPressed: () {
                                                 // Add favorite functionality here
                                               },
                                             ),
                                             IconButton(
                                               icon: const Icon(Icons.warning_amber_outlined),
                                               onPressed: () {
                                                vm.reportQuestionBottomSheet(context, vm.quizData[vm.currentPageIndex.value]);
                                               },
                                             ),
                                             IconButton(
                                               icon: const Icon(Icons.share),
                                               onPressed: () {
                                                 // Add share functionality here
                                               },
                                             ),
                                           ],
                                         ),
                         ],
                       ),
                       const SizedBox(height: 10),
                       Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Html(
                              data: vm.isHindi ? (vm.quizData[vm.currentPageIndex.value].questionHi ?? "No question available") : (vm.quizData[vm.currentPageIndex.value].question ?? "No question available"),
                              style: {
                                "body": Style(
                                  fontSize: FontSize(16.0),
                                  fontWeight: FontWeight.w500,
                                ),
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      OptionTile(
                        option: 'A',
                        text: vm.isHindi ? vm.quizData[vm.currentPageIndex.value].options1Hi ?? '' : vm.quizData[vm.currentPageIndex.value].options1 ?? '',
                        optionIndex: 0,
                        selectedOptionIndex: vm.selectedOptionIndex.value,
                        correctOptionIndex: int.tryParse(vm.quizData[vm.currentPageIndex.value].correctoption ?? '0') ?? 0,
                        showIndicators: vm.selectedOptionIndex.value != null,
                        onSelect: () {
                          _handleOptionSelect(vm.currentPageIndex.value, 0, vm.quizData[vm.currentPageIndex.value]);
                          vm.submitQuizAnswer(vm.quizData[vm.currentPageIndex.value].id.toString(), vm.isHindi?vm.quizData[vm.currentPageIndex.value].options1Hi.toString():vm.quizData[vm.currentPageIndex.value].options1.toString(), vm.token);
                          vm.showDescription.value=true;
                          vm.getAllDescription(vm.quizData[vm.currentPageIndex.value].id.toString());
                        },
                      ),
                      OptionTile(
                          option: 'B',
                          text: vm.isHindi ? vm.quizData[vm.currentPageIndex.value].options2Hi ?? '' : vm.quizData[vm.currentPageIndex.value].options2 ?? '',
                          optionIndex: 1,
                          selectedOptionIndex: vm.selectedOptionIndex.value,
                          correctOptionIndex: int.tryParse(vm.quizData[vm.currentPageIndex.value].correctoption ?? '0') ?? 0,
                          showIndicators: vm.selectedOptionIndex.value != null,
                          onSelect: () {
                            _handleOptionSelect(vm.currentPageIndex.value, 1, vm.quizData[vm.currentPageIndex.value]);
                            vm.submitQuizAnswer(vm.quizData[vm.currentPageIndex.value].id.toString(), vm.isHindi?vm.quizData[vm.currentPageIndex.value].options2Hi.toString():vm.quizData[vm.currentPageIndex.value].options2.toString(), vm.token);
                            vm.showDescription.value=true;
                            vm.getAllDescription(vm.quizData[vm.currentPageIndex.value].id.toString());
              
                          }
                      ),
                      OptionTile(
                          option: 'C',
                          text: vm.isHindi ? vm.quizData[vm.currentPageIndex.value].options3Hi ?? '' : vm.quizData[vm.currentPageIndex.value].options3 ?? '',
                          optionIndex: 2,
                          selectedOptionIndex: vm.selectedOptionIndex.value,
                          correctOptionIndex: int.tryParse(vm.quizData[vm.currentPageIndex.value].correctoption ?? '0') ?? 0,
                          showIndicators: vm.selectedOptionIndex.value != null,
                          onSelect: () {
                            _handleOptionSelect(vm.currentPageIndex.value, 2, vm.quizData[vm.currentPageIndex.value]);
                            vm.submitQuizAnswer(vm.quizData[vm.currentPageIndex.value].id.toString(), vm.isHindi?vm.quizData[vm.currentPageIndex.value].options3Hi.toString():vm.quizData[vm.currentPageIndex.value].options3.toString(), vm.token);
                            vm.showDescription.value=true;
                            vm.getAllDescription(vm.quizData[vm.currentPageIndex.value].id.toString());
              
                          }
                      ),
                      OptionTile(
                          option: 'D',
                          text: vm.isHindi ? vm.quizData[vm.currentPageIndex.value].options4Hi ?? '' : vm.quizData[vm.currentPageIndex.value].options4 ?? '',
                          optionIndex: 3,
                          selectedOptionIndex: vm.selectedOptionIndex.value,
                          correctOptionIndex: int.tryParse(vm.quizData[vm.currentPageIndex.value].correctoption ?? '0') ?? 0,
                          showIndicators: vm.selectedOptionIndex.value != null,
                          onSelect: () { _handleOptionSelect(vm.currentPageIndex.value, 3, vm.quizData[vm.currentPageIndex.value]);
                          vm.submitQuizAnswer(vm.quizData[vm.currentPageIndex.value].id.toString(), vm.isHindi ? vm.quizData[vm.currentPageIndex.value].options4Hi.toString():vm.quizData[vm.currentPageIndex.value].options4.toString(), vm.token);
                          vm.showDescription.value=true;
                          vm.getAllDescription(vm.quizData[vm.currentPageIndex.value].id.toString());
              
                          }
                      ),
                      if ((vm.isHindi ? vm.quizData[vm.currentPageIndex.value].options5Hi?.isNotEmpty : vm.quizData[vm.currentPageIndex.value].options5?.isNotEmpty) ?? false)
                        OptionTile(
                            option: 'E',
                            text: vm.isHindi ? vm.quizData[vm.currentPageIndex.value].options5Hi ?? '' : vm.quizData[vm.currentPageIndex.value].options5 ?? '',
                            optionIndex: 4,
                            selectedOptionIndex: vm.selectedOptionIndex.value,
                            correctOptionIndex: int.tryParse(vm.quizData[vm.currentPageIndex.value].correctoption ?? '0') ?? 0,
                            showIndicators: vm.selectedOptionIndex.value != null,
                            onSelect: () { _handleOptionSelect(vm.currentPageIndex.value, 4, vm.quizData[vm.currentPageIndex.value]);
                            vm.submitQuizAnswer(vm.quizData[vm.currentPageIndex.value].id.toString(), vm.isHindi ?vm.quizData[vm.currentPageIndex.value].options5Hi.toString():vm.quizData[vm.currentPageIndex.value].options5.toString(), vm.token);
                            vm.showDescription.value=true;
                            vm.getAllDescription(vm.quizData[vm.currentPageIndex.value].id.toString());
              
              
                            }
                        ),
                      const SizedBox(height: 20),
                      vm.showDescription.value && vm.selectedOptionIndex.value != null
                          ?Visibility(
                        visible: vm.showDescription.value,
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
                                              vm.descriptionToggle.value = !vm.descriptionToggle.value;
                                            });
                                          },
                                          icon: Icon(
                                              vm.descriptionToggle.value
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
                                            controller: vm.textController,
                                            onChanged: (text) {
                                              vm.isTextNotEmpty.value = text.isNotEmpty;
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
                                            vm.pickImage();
              
                                          },
                                        ),
                                        const SizedBox(width: 10),
                                        ValueListenableBuilder<bool>(
                                          valueListenable: vm.isTextNotEmpty,
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
                                                  await vm.saveData(vm.textController.text, vm.quizData[vm.currentPageIndex.value].id.toString(),);
                                                  vm.textController.clear();
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
                            vm.quizData[vm.currentPageIndex.value].questionno!.isNotEmpty?
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
                                            vm.quizData[vm.currentPageIndex.value].solutionHi.toString(),
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
                                vm.alldescription.isNotEmpty
                                ?ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: vm.alldescription.length,
                              itemBuilder: (context, index) {
                                final description = vm.alldescription[index];
                                 vm.isLiked.value = description.isLike ?? false;
                                final descriptionFav = vm.alldescription[index];
                                final isFavourite = description.isFavourite ?? false;

                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.blue.withOpacity(0.1), // Use a static color for demonstration
                                    ),
                                    child: Visibility(
                                      visible: vm.descriptionToggle.value, // Static visibility, always visible
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
                                                          child:
                                                          vm.alldescription[index].userImage != null && vm.alldescription[index].userImage!.isNotEmpty
                                                              ? Image.network(vm.alldescription[index].userImage.toString(),
                                                            fit: BoxFit.cover,

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
                                                            vm.alldescription[index].userName ?? "",
                                                            style: TextStyle(
                                                                color: Colors.black.withOpacity(0.5),
                                                                fontSize: 19,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          Text(
                                                            vm.alldescription[index].time ?? "",
                                                            style: TextStyle(
                                                              color: Colors.black.withOpacity(0.5),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    UserActionButton(
                                                      iconData: isFavourite
                                                          ? FontAwesomeIcons.solidHeart
                                                          : FontAwesomeIcons.heart,
                                                      color: isFavourite ? Colors.cyan : Colors.cyan,
                                                      value: '0', // Static value
                                                      onTap: () {
                                                        // Static action
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
                                                if (
                                                vm.alldescription[index].image != null && vm.alldescription[index].image!.isNotEmpty)
                                                  SizedBox(
                                                    width: 200,
                                                    height: 400,
                                                    child: Image.network(
                                                      vm.alldescription[index].image.toString(),
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
                                                UserActionButton(
                                                  iconData: vm.isLiked.value ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
                                                  color: vm.isLiked.value ? Colors.blue : Colors.blue,
                                                  value: vm.alldescription[index].likes.toString(),
                                                  onTap: ()  {
                                                   setState(() {
                                                     vm.toggleLike(index);
                                                   });
                                                  },
                                                ),
                                                const SizedBox(width: 10),


                                                const SizedBox(width: 10),
                                                UserActionButton(
                                                  iconData: FontAwesomeIcons.comment,
                                                  color: Colors.lightBlue,
                                                  value: vm.alldescription[index].commentUser!.length.toString(),
                                                  onTap: () {

                                                      vm.showCommentSheet(context, index);

                                                  },
                                                ),
                                                const SizedBox(width: 10),
                                                UserActionButton(
                                                  iconData: FontAwesomeIcons.solidShareFromSquare,
                                                  color: Colors.lightBlue,
                                                  value: vm.alldescription[index].share.toString(),
                                                  onTap: () async {
                                                   await vm.handleAction(index: index, type: 'share');
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
                                                      // Static action
                                                        break;
                                                      case 'Edit':
                                                      // Static action
                                                        break;
                                                      case 'Delete':
                                                      // Static action
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
                                :const SizedBox.shrink(),
              
                          ],
                        ),
                      )
                          :const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
                       const SizedBox(height: 150,)
              
                ],
              ),
            );}
      ),
    );
  }
}

