import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/color.dart';

import '../views/screens/checkScrore/checkscore_view_model.dart';
import 'cutoff_score.dart';

late Size mq;

class CheckScore extends StatefulWidget {
  const CheckScore({super.key});

  @override
  State<CheckScore> createState() => _CheckScoreState();
}

class _CheckScoreState extends State<CheckScore> {
  final vm = Get.put(CheckScoreViewModel());

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Check Score',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: mq.height * 0.020),
        child: Obx(()=>
          vm.loading.value && vm.examList.isEmpty?
              Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor,)):ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  vm.getCutoff(vm.examList[index].id);
                  Get.to(() => const CutoffScore());
                },
                child: Card(
                  margin: EdgeInsets.symmetric(
                      vertical: mq.height * .010, horizontal: mq.width * .030),
                  elevation: 8,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(vm.examList[index].image?? '',fit: BoxFit.cover,
                            height: 50,)),
                    ),
                    title: Text(
                      vm.examList[index].name??'',
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                    subtitle: Text(
                      vm.formatDateTime(vm.examList[index].startDatetime),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.blue,
                    ),
                  ),
                ),
              );
            },
            itemCount: vm.examList.length,
          ) ),
      ),
    );
  }
}
