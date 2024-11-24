
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/checkScore/admit_card.dart';
import 'package:mcq/checkScore/list1.dart';

import '../themes/color.dart';
import '../views/screens/checkScrore/checkscore_view_model.dart';
import 'check_score.dart';

class YourScore extends StatefulWidget {
  const YourScore({super.key});

  @override
  State<YourScore> createState() => _YourScoreState();
}

class _YourScoreState extends State<YourScore> {
  final vm = Get.put(CheckScoreViewModel());

  @override
  void initState() {
    super.initState();
    // Initialize the ViewModel
    vm.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(mq.width * .030),
      child: Obx(
        ()=>vm.loading.value?
             Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            )
          :Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: mq.width * .90,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue)),
                  onPressed: () {
                    Get.to(const AdmitCard());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(mq.height * .01),
                    child: const Text(
                      'New Check Score',
                      style: TextStyle(fontSize: 20.0, color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mq.height * .03,
            ),

           Expanded(
             child: vm.scoreDataList.isNotEmpty
                   ?ListView.builder(
                   shrinkWrap: true,
                   physics: const ScrollPhysics(),
                   itemCount: vm.scoreDataList.length,
                   itemBuilder: (context, index) {
                   return InkWell(
                     onTap: (){
                       Get.to(ScoreCardScreen(), arguments: vm.scoreDataList[index].id);
                       print("Id: ${vm.scoreDataList[index].id}");
                     },
                     child: Card(
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(16.0),
                       ),
                       elevation: 8,
                       child: Padding(
                         padding: EdgeInsets.all(mq.width * .02),
                         child: Row(
                           children: [
                             Expanded(
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                    Text(
                                     vm.scoreDataList[index].userName.toString(),
                                     style: const TextStyle(
                                       fontSize: 18.0,
                                       fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                   SizedBox(
                                     height: mq.height * .002,
                                   ),
                                     Text(
                                      vm.scoreDataList[index].examName.toString(),
                                     style: const TextStyle(
                                       fontSize: 14.0,
                                       color: Colors.grey,
                                     ),
                                   ),
                                   SizedBox(
                                     height: mq.height * .002,
                                   ),
                                   LinearProgressIndicator(
                                     value: vm.scoreDataList[index].rankDetails!.percentile, // Assuming 75% progress
                                     color: Colors.green,
                                     backgroundColor: Colors.grey.shade300,
                                   ),
                                   SizedBox(
                                     height: mq.height * .002,
                                   ),
                                    Row(
                                     children: [
                                       Row(
                                         children: [
                                           Text(
                                             vm.scoreDataList[index].rankDetails!.rank.toString(),
                                             style: const TextStyle(
                                               fontWeight: FontWeight.bold,
                                               fontSize: 16.0,
                                             ),
                                           ),
                                           const Text(
                                             ' Rank',
                                             style: TextStyle(
                                               fontSize: 14.0,
                                               color: Colors.grey,
                                             ),
                                           ),
                                         ],
                                       ),
                                       Spacer(),
                                       Text(
                                         'out of ${vm.scoreDataList[index].rankDetails!.totalCondidate}',
                                         style: TextStyle(
                                           color: Colors.grey,
                                         ),
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                             ),
                             Column(
                               children: [
                                 IconButton(
                                   icon: const Icon(Icons.refresh,size: 30,),
                                   onPressed: () {
                                     // Add your onPressed code here!
                                   },
                                 ),
                                 IconButton(
                                   icon: const Icon(Icons.delete_outline,size: 30,),
                                   onPressed: () {
                                     // Add your onPressed code here!
                                   },
                                 ),
                               ],
                             ),
                           ],
                         ),
                       ),
                     ),
                   );
             
               },)
                   :SizedBox.shrink(),
           ),

          ],
        ),
      ),
    ));
  }
}
