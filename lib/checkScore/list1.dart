import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mcq/checkScore/list2.dart';
import 'package:mcq/checkScore/score_card.dart';
import 'package:mcq/checkScore/third.dart';
import '../themes/color.dart';
import '../views/screens/checkScrore/checkscore_view_model.dart';
import 'questionanswer.dart';

class ScoreCardScreen extends StatefulWidget {
  ScoreCardScreen({super.key});

  @override
  State<ScoreCardScreen> createState() => _ScoreCardScreenState();
}

class _ScoreCardScreenState extends State<ScoreCardScreen> {
  final vm = Get.put(CheckScoreViewModel());
  bool isHindi = true; // Initial language setting

  @override
  void initState() {
    super.initState();
    // Initialize the ViewModel
    vm.init();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back),
          ),
          title: const Text('Exam name', style: TextStyle(color: Colors.white)),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text('Hindi', style: TextStyle(color: Colors.white)),
                  Switch(
                    value: isHindi,
                    onChanged: (value) {
                      setState(() {
                        isHindi = value;
                      });
                    },
                    activeColor: Colors.white,
                    inactiveThumbColor: Colors.grey,
                  ),
                  const Text('English', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Row(
                  children: [
                    Icon(Icons.score, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      'Score Card',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    Icon(Icons.question_answer_rounded, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      'Question & Answer',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
            // Score Card Screen
            SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        color: AppColors.second,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: vm.scoreCardDetails.value!=null
                            ?Padding(
                            padding: const EdgeInsets.all(16.0),
                            child:Column(
                              children: [
                                 Row(
                                  children: [
                                    const CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                    const SizedBox(width: 18,),
                                    Column(
                                      children: [
                                        Text(
                                          vm.scoreCardDetails.value!.userDetails!.candidateName.toString(),
                                          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                                        ),
                                         Text(vm.scoreCardDetails.value!.userDetails!.state.toString(),
                                          style: const TextStyle(fontSize: 14,),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(vm.scoreCardDetails.value!.userDetails!.casteCategory.toString(),)
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                Container(width: 400,height: 1, color: Colors.pink,),
                                const SizedBox(height: 8),
                                 Row(
                                  children: [
                                    const Text('Roll no.', style: TextStyle(fontWeight: FontWeight.bold)),
                                    const Spacer(),

                                    Text(vm.scoreCardDetails.value!.userDetails!.rollNo.toString(),),

                                    const SizedBox(width: 8),
                                    const Icon(Icons.visibility, size: 18),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                 Row(
                                  children: [
                                    const Text('Exam Shift', style: TextStyle(fontWeight: FontWeight.bold)),
                                    const Spacer(),

                                    Text(vm.scoreCardDetails.value!.userDetails!.shiftName.toString(),),
                                  ],
                                ),
                              ],


                            )
                        )
                            :const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 16),
                       const Row(
                        children: [
                          Text(
                            'QUICK SUMMARY',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            'OBC Cutoff : 72.75',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                        ],
                      ),
                      Card(
                        color: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                             Padding(
                              padding:  const EdgeInsets.all(5.0),
                              child: ScoreSummaryRow(
                                icon: FontAwesomeIcons.trophy ,
                 
                                label: 'Score',
                                value: '${vm.scoreCardDetails.value?.totalMarks.toString()}/${vm.scoreCardDetails.value?.totalQuestions.toString()}' ,

                                color: Colors.purple.shade50, iconColor: Colors.brown,

                              ),
                            ),
                            Padding(
                              padding:  const EdgeInsets.only(bottom: 10,right: 12,left:75),
                              child: Container(

                                height: 1, width: double.infinity, color: Colors.black,
                              ),
                            ),
                            vm.scoreCardDetails.value!=null
                                ?Padding(
                              padding:  const EdgeInsets.only(left: 145, bottom:2
                              ),
                              child: Text('+ve Score : ${vm.scoreCardDetails.value!.totalPositiveMarks.toString()}   -ve Score : ${vm.scoreCardDetails.value!.totalPositiveMarks.toString()}'),
                            )
                                :const SizedBox.shrink()

                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        color: AppColors.second,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [

                               ScoreSummaryRow(
                                icon: Icons.flag,
                                label: 'Rank',
                                value: '7629/${vm.scoreCardDetails.value?.ranking?.all?.totalusers.toString()}',
                                color:AppColors.seconds, iconColor: Colors.deepOrangeAccent,
                              ),
                              const Divider(),
                              ScoreSummaryRow(
                                icon: Icons.percent,
                                label: 'Percentile',
                                value: "${vm.scoreCardDetails.value?.ranking?.all?.percentile.toString()}%",
                                color: Colors.purple.shade50, iconColor: Colors.purple,
                              ),
                              const Divider(),
                              ScoreSummaryRow(
                                icon: Icons.light_mode_outlined,
                                label: 'Accuracy',
                                value: "${vm.scoreCardDetails.value?.accuracy.toString()}%",
                                color: Colors.green.shade50, iconColor: Colors.lightGreen,
                              ),

                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),

                     ScoreCard(),

                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            width: Get.width/4,
                            decoration: BoxDecoration(
                                color: AppColors.thirdE,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: const Padding(
                              padding:  EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.share,color: Colors.white,),
                                  Text('Share',style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            )
                        ),
                      ),
                      const SizedBox(height: 15,),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Section Analysis", style: TextStyle(fontWeight: FontWeight.bold),),

                          ],
                        ),
                      ),
                      ScoreScreen(),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Ranking", style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("All/Male/Female", style: TextStyle(fontWeight: FontWeight.bold),),

                          ],
                        ),
                      ),

                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Rank",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),


                                        const SizedBox(
                                          height: 15,
                                        ),
                                        LinearProgressIndicator(
                                          value: vm.scoreCardDetails.value?.ranking?.all?.percentile?.toDouble()??0.0, // Assuming 75% progress
                                          color: Colors.green,
                                          backgroundColor: Colors.grey.shade300,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                         Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  vm.scoreCardDetails.value?.ranking?.all?.rank?.toString() ?? 'N/A',
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
                                            const Spacer(),
                                            Text(
                                              "Out Of ${vm.scoreCardDetails.value?.ranking?.all?.totalusers.toString()??"0"}",
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Rank after normalisation",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),


                                        const SizedBox(
                                          height: 15,
                                        ),
                                        LinearProgressIndicator(
                                          value: vm.scoreCardDetails.value?.ranking?.all?.percentile?.toDouble()??0.0, // Assuming 75% progress
                                          color: Colors.green,
                                          backgroundColor: Colors.grey.shade300,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                         Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  vm.scoreCardDetails.value?.ranking?.all?.rankAfterNormalisation?.toString()??'0',
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
                                            const Spacer(),
                                             Text(
                                              'out of ${vm.scoreCardDetails.value?.ranking?.all?.rank?.toString()??"0"}',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),

                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Category Rank - OBC",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),


                                        const SizedBox(
                                          height: 15,
                                        ),
                                        LinearProgressIndicator(
                                          value: vm.scoreCardDetails.value?.ranking?.all?.percentile?.toDouble()??0.0, // Assuming 75% progress
                                          color: Colors.green,
                                          backgroundColor: Colors.grey.shade300,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                         Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  vm.scoreCardDetails.value?.ranking?.all?.categoryRank.toString()??"0",
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
                                            const Spacer(),
                                            Text(
                                              'out of ${vm.scoreCardDetails.value?.ranking?.all?.categoryTotalusers.toString()??""}',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Category Rank AN - OBC",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),


                                        const SizedBox(
                                          height: 15,
                                        ),
                                        LinearProgressIndicator(
                                          value: vm.scoreCardDetails.value?.ranking?.all?.percentile?.toDouble()??0.0, // Assuming 75% progress
                                          color: Colors.green,
                                          backgroundColor: Colors.grey.shade300,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                         Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  vm.scoreCardDetails.value?.ranking?.all?.categoryRankAfterNormalisation.toString()??"0",
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
                                            const Spacer(),
                                            Text(
                                              'out of ${vm.scoreCardDetails.value?.ranking?.all?.categoryRank.toString()??"0"}',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),


            // Question Answer Screen with language toggle
            const QuestionAnswerScreen(),
          ],
        ),
      ),
    );
  }
}
