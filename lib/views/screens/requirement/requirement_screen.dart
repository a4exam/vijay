import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/custom_text_field.dart';
import 'package:mcq/views/components/custom_text_field_with_image.dart';
import 'package:mcq/views/components/loading_overlay.dart';
import 'package:mcq/views/screens/requirement/components/rating_view.dart';
import 'package:mcq/views/screens/requirement/requirement_view_model.dart';

import 'requirement_utils.dart';

class RequirementScreen extends StatefulWidget {
  final RequirementViewModel vm;

  const RequirementScreen({super.key, required this.vm});

  @override
  State<RequirementScreen> createState() => _RequirementScreenState();
}

class _RequirementScreenState extends State<RequirementScreen> {
  @override
  Widget build(BuildContext context) {
    return LoadingOverView(
      loading: widget.vm.loading,
      child: Scaffold(
        appBar: AppBar(title: const Text('Requirement')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'How would you rate your experience?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    height: 120,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: RequirementUtils.ratingList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                            width:
                                RequirementUtils.ratingList.length - 1 == index
                                    ? 0
                                    : 10);
                      },
                      itemBuilder: (context, index) {
                        var item = RequirementUtils.ratingList[index];
                        return Obx(
                          () => RatingView(
                            item: item,
                            onPressed: widget.vm.setSelectedRating,
                            isSelected: widget.vm.selectedRating.value ==
                                item.rateValue,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'What can we improve?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                /// improve Text
                const SizedBox(height: 16),
                CustomTextField(
                  controller: widget.vm.improveController,
                  labelText: "Title",
                ),

                /// Requirement text field
                const SizedBox(height: 16),
                CustomTextFieldWithImage(
                  controller: widget.vm.aboutProblemController,
                  hintText: "Write about the problem",
                ),

                /// submit button
                const SizedBox(height: 32),
                CustomButton(
                  title: 'Submit',
                  width: Get.width,
                  onPressed: widget.vm.onPressedSubmitBtn,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
