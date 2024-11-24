import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/utils/utils.dart';
import 'package:mcq/view_models/UserDataViewModel.dart';
import 'package:mcq/views/screens/home/home_utils.dart';

class HomeDrawerScreen extends StatefulWidget {
  final Function(Screens) callBackForGotoNewScreen;
  final Function() onDismiss;

  const HomeDrawerScreen({
    super.key,
    required this.callBackForGotoNewScreen,
    required this.onDismiss,
  });

  @override
  State<HomeDrawerScreen> createState() => _HomeDrawerScreenState();
}

class _HomeDrawerScreenState extends State<HomeDrawerScreen> {
  final userDataVm = Get.put(UserdataViewModel());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xfff4f8fe),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: widget.onDismiss,
                  icon: const Icon(
                    Icons.close_outlined,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                margin: const EdgeInsets.only(right: 50, left: 50, bottom: 50),
                elevation: AppElevations.cardElevation,
                shape: AppShapes.cardShape,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: Get.height * 0.14),
                        Obx(
                              () => Center(
                            child: Text(
                              userDataVm.userData.value?.fullName ?? 'Default Name',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Obx(
                              () => Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  userDataVm.userData.value?.mobileNo ?? 'Default Mobile No',
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(width: 5),
                                const Icon(Icons.check_circle, color: Colors.green),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * .01),
                        Flexible(
                          child: ListView(
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: HomeUtils.drawerList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var item = HomeUtils.drawerList[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                                      foregroundColor: AppColors.primaryColor,
                                      child: Icon(item.icon),
                                    ),
                                    trailing: const Icon(Icons.chevron_right),
                                    title: Text(item.title),
                                    onTap: () {
                                      widget.onDismiss();
                                      widget.callBackForGotoNewScreen(item.screenName);
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: -40,
                      left: 0,
                      right: 0,
                      child: CircleAvatar(
                        maxRadius: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Obx(
                                () => Image.network(
                              userDataVm.userData.value!.images.toString()??"",
                              fit: BoxFit.cover,
                              height: 120,
                              width: 120,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
