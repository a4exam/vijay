import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/checkScrore/cutOffScoreResponse.dart';
import '../views/screens/checkScrore/checkscore_view_model.dart';

class CutOff extends StatefulWidget {
  const CutOff({super.key});

  @override
  State<CutOff> createState() => _CutOffState();
}

class _CutOffState extends State<CutOff> {
  final vm = Get.put(CheckScoreViewModel());

  @override
  void initState() {
    super.initState();
    // Initialize the ViewModel
    vm.init();

  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(mq.width * .04),
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                        () => DropdownButtonFormField<String>(
                      value: vm.selectedGender.value,
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: <String>['All', 'Male', 'Female'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          vm.selectedGender.value = newValue;
                          vm.filterData(); // Apply filtering when gender changes
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: mq.height * .010),
          Padding(
            padding: EdgeInsets.only(left: mq.width * .05, right: mq.width * .05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                      () => Text(
                    'Selected ${vm.totalQualify.value}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Out Of ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Obx(
                          () => Text(
                        '${vm.totalCandidates}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: mq.height * 0.020),
              child: Obx(() {
                final genderData = vm.selectedGender.value == 'Female'
                    ? vm.femaleCutOff.value
                    : vm.selectedGender.value == 'Male'
                    ? vm.maleCutOff.value
                    : vm.allCutOff.value;

                if (genderData == null) {
                  return const Center(child: Text('No data available'));
                }

                // Combine all categories for the selected gender, check for nulls
                List<Ews> ewsList = [];
                if (genderData.ews != null) ewsList.add(genderData.ews!);
                if (genderData.general != null) ewsList.add(genderData.general!);
                if (genderData.obc != null) ewsList.add(genderData.obc!);
                if (genderData.sc != null) ewsList.add(genderData.sc!);
                if (genderData.st != null) ewsList.add(genderData.st!);

                return ListView.builder(
                  itemCount: ewsList.length,
                  itemBuilder: (context, index) {
                    final ews = ewsList[index];
                    final categories = ['EWS', 'General', 'OBC', 'SC', 'ST'];

                    return Card(
                      margin: EdgeInsets.symmetric(
                        vertical: mq.height * .010,
                        horizontal: mq.width * .030,
                      ),
                      elevation: 8,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          child: Text(ews.cutoff.toString()), // Display cutoff value
                        ),
                        title: Text(
                          categories[index % categories.length],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${ews.qualifyUser} ',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Text('Selected'),
                              ],
                            ),
                            Text(
                              'out of ${ews.totalUser}',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
