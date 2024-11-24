import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/helpers/navigation_helper.dart';
import 'package:mcq/views/screens/previous_year/tab/tab_screen.dart';
import 'package:mcq/views/screens/previous_year/components/coures.dart';
import 'package:sizer/sizer.dart';

class PreviousYearScreen extends StatefulWidget {
  const PreviousYearScreen({super.key});

  @override
  State<PreviousYearScreen> createState() => _PreviousYearScreenState();
}

class _PreviousYearScreenState extends State<PreviousYearScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            SizedBox(
              width: 2.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Previous Year"),
                Text(
                  "Question Paper",
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 8,
            itemBuilder: (context, index) {
              return Courses(onTap: () {
                Get.to(
                  const PreviousYearInsideScreen(),
                  transition: Transition.rightToLeft,
                );
              });
            }),
      ),
    );
  }
}
