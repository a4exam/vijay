import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/views/screens/home/home_utils.dart';
import 'package:mcq/views/screens/home/home_view_model.dart';
import 'package:mcq/views/screens/home/components/book_section.dart';
import 'package:mcq/views/screens/home/components/image_slider.dart';
import 'package:mcq/views/components/test_progress_view.dart';
import 'package:sizer/sizer.dart';
import 'package:mcq/views/screens/home/components/simmer_loading.dart';

class HomeScreen extends StatefulWidget {
  final HomeViewModel vm;

  const HomeScreen({
    super.key,
    required this.vm,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: widget.vm.onPressedNotificationBtn,
            icon: const Icon(Icons.notifications),
          )
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                widget.vm.gotoNextScreen(Screens.homeDrawer);
              },
            ),
            const SizedBox(width: 5),
            const Text("Home"),
          ],
        ),
      ),
      body: Obx(
        () => widget.vm.simmerLoading.value
            ? const HomeSimmerLoading()
            : ListView(
                children: [
                  /// Image Slider
                  SizedBox(height: Get.height * .02),
                  ImageSlider(imageList: HomeUtils.imgList),

                  /// Continue Practice
                  SizedBox(height: Get.height * .02),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32.0),
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.54629.w,
                      vertical: 1.36026.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 207, 204, 204),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Continue Practice",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 2.94459.h,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 8.96182.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return TestProgressView(
                                title: "Biology Discovery",
                                width: 70.w,
                                isTrailingShow: false,
                                margin: const EdgeInsets.only(right: 10),
                                onPressed: () {},
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// BookSections
                  SizedBox(height: Get.height * .02),
                  GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: .8,
                    ),
                    itemCount: HomeUtils.bookList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BookSection(
                        data: HomeUtils.bookList[index],
                        onPressed: widget.vm.gotoNextScreen,
                      );
                    },
                  ),

                  SizedBox(height: Get.height * .1),
                ],
              ),
      ),
    );
  }
}
