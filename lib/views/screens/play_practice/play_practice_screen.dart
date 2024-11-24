import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/helpers/navigation_helper.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:sizer/sizer.dart';

import 'create_player_room_screen.dart';

class PlayPracticeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: "Play",
                        height: 40,
                        onPressed: (){},
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomButton(
                        title: "Create",
                        height: 40,
                        onPressed: (){
                          Get.to(
                            const CreatePlayerRoomScreen(),
                            transition: Transition.rightToLeft,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomButton(
                  width: 100.w,
                  title: "Join",
                  height: 40,
                  onPressed: (){},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

