import 'package:flutter/material.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/questions_status_flag.dart';
import 'package:sizer/sizer.dart';

class TopHeader extends StatefulWidget {
  const TopHeader({super.key});

  @override
  State<TopHeader> createState() => _TopHeaderState();
}

class _TopHeaderState extends State<TopHeader> {
  bool _showCheckBox = false;

  var title = ["Correct", "Incorrect", "Unseen", "Unattempted", "Marked"];
  var color = [
    Colors.green,
    Colors.red,
    Colors.white,
    Colors.grey,
    Colors.yellow
  ];
  var isSelected = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.4.w,
            ),
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return QuestionsStatusFlag(
                title: title[index],
                color: color[index],
                isSelected: isSelected[index],
                showCheckBox: _showCheckBox,
                onChanged: (newValue) {
                  setState(
                    () {
                      isSelected[index] = newValue!;
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 5),
          _showCheckBox
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CustomBorderButton(
                        title: "Cancel",
                        height: 25,
                        onPressed: () {
                          setState(() {
                            _showCheckBox = !_showCheckBox;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        title: "Clean history",
                        height: 25,
                        onPressed: () {},
                      ),
                    )
                  ],
                )
              : Row(
                  children: [
                    const Spacer(),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        title: "Clean history",
                        height: 25,
                        onPressed: () {
                          setState(() {
                            _showCheckBox = !_showCheckBox;
                          });
                        },
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
