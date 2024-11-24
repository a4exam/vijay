import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/screens/checkScrore/checkscore_view_model.dart';



class ScoreScreen extends StatefulWidget {
  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  final vm = Get.put(CheckScoreViewModel());

  @override
  void initState() {
    super.initState();
    // Initialize the ViewModel
    vm.init();
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
            () => vm.scoreCardDetails.value != null
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GK Section
            if (vm.scoreCardDetails.value!.sectionWiseMarks?.gK != null)
              ScoreSection(
                subject: "GK",
                score: vm.scoreCardDetails.value!.sectionWiseMarks!.gK!.total?.toDouble() ?? 0.0,
                correct: vm.scoreCardDetails.value!.sectionWiseMarks!.gK!.correct ?? 0,
                incorrect: vm.scoreCardDetails.value!.sectionWiseMarks!.gK!.incorrect ?? 0,
                unattempted: vm.scoreCardDetails.value!.sectionWiseMarks!.gK!.notAttempted ?? 0,
              ),
            const Divider(),

            // Maths Section
            if (vm.scoreCardDetails.value!.sectionWiseMarks?.math != null)
              ScoreSection(
                subject: "Maths",
                score: 14.5, // Hardcoded value
                correct: vm.scoreCardDetails.value!.sectionWiseMarks!.math!.correct ?? 0,
                incorrect: vm.scoreCardDetails.value!.sectionWiseMarks!.math!.incorrect ?? 0,
                unattempted: vm.scoreCardDetails.value!.sectionWiseMarks!.math!.notAttempted ?? 0,
              ),
            Divider(),

            // Hindi Section
            if (vm.scoreCardDetails.value!.sectionWiseMarks?.hindi != null)
              ScoreSection(
                subject: "Hindi",
                score: 14.5, // Hardcoded value
                correct: vm.scoreCardDetails.value!.sectionWiseMarks!.hindi!.correct ?? 0,
                incorrect: vm.scoreCardDetails.value!.sectionWiseMarks!.hindi!.incorrect ?? 0,
                unattempted: vm.scoreCardDetails.value!.sectionWiseMarks!.hindi!.notAttempted ?? 0,
              ),
            Divider(),

            // English Section
            if (vm.scoreCardDetails.value!.sectionWiseMarks?.english != null)
              ScoreSection(
                subject: "English",
                score: 14.5, // Hardcoded value
                correct: vm.scoreCardDetails.value!.sectionWiseMarks!.english!.correct ?? 0,
                incorrect: vm.scoreCardDetails.value!.sectionWiseMarks!.english!.incorrect ?? 0,
                unattempted: vm.scoreCardDetails.value!.sectionWiseMarks!.english!.notAttempted ?? 0,
              ),
          ],
        )
            : SizedBox.shrink(),
      ),

    );
  }
}

class ScoreSection extends StatelessWidget {
  final String subject;
  final double score;
  final int correct;
  final int incorrect;
  final int unattempted;

  const ScoreSection({super.key,
    required this.subject,
    required this.score,
    required this.correct,
    required this.incorrect,
    required this.unattempted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subject,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Score",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "$score/25",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: correct,
              child: Container(
                height: 8,
                color: Colors.green,
              ),
            ),
            Expanded(
              flex: incorrect,
              child: Container(
                height: 8,
                color: Colors.red,
              ),
            ),
            Expanded(
              flex: unattempted,
              child: Container(
                height: 8,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Correct: $correct"),
            Text("Incorrect: $incorrect"),
            Text("Unattempted: $unattempted"),
          ],
        ),
      ],
    );
  }
}
