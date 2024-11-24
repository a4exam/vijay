import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/color.dart';
import '../views/screens/checkScrore/checkscore_view_model.dart';


class ScoreCard extends StatefulWidget {
  const ScoreCard({super.key});

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  final vm = Get.put(CheckScoreViewModel());

  @override
  void initState() {
    super.initState();
    // Initialize the ViewModel
    vm.init();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.third,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4,

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.lightBlue[100],
                  child: const Icon(
                    Icons.description,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 8.0),
                const Text(
                  'Qs. Attempted',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                 Obx(
                   ()=> Text(
                     vm.scoreCardDetails.value!=null?"${vm.scoreCardDetails.value!.attemptedQuestions}/${vm.scoreCardDetails.value!.totalQuestions}":"",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                                   ),
                 ),
              ],
            ),
            const SizedBox(height: 16.0),
            vm.scoreCardDetails.value!=null
                ?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusCard(Icons.check_circle, 'Correct', vm.scoreCardDetails.value!.correctAnswers??0, Colors.green),
                _buildStatusCard(Icons.cancel, 'Incorrect', vm.scoreCardDetails.value!.incorrectAnswers??0, Colors.red),
                _buildStatusCard(Icons.help, 'Unattempted', vm.scoreCardDetails.value!.unattemptedQuestions??0, Colors.grey),
              ],
            )
                :SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(IconData icon, String label, int value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 10.0,
          ),
          const SizedBox(width: 10.0),
          Text(
            '$label : $value',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 10
            ),
          ),
        ],
      ),
    );
  }
}
