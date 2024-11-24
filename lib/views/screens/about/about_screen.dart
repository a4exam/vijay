import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/utils/utils.dart';
import 'package:mcq/views/components/loading_overlay.dart';
import 'package:mcq/views/screens/about/about_utlis.dart';
import 'package:mcq/views/screens/about/about_view_model.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final vm = Get.put(AboutViewModel());

  @override
  Widget build(BuildContext context) {
    return LoadingOverView(
      loading: vm.loading,
      child: Scaffold(
        appBar: AppBar(title: const Text("About us")),
        body: Card(
          margin: const EdgeInsets.all(32),
          elevation: AppElevations.cardElevation,
          shape: AppShapes.cardShape,
          child: ListView.builder(
            itemCount: AboutUtils.followUsItems.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var item = AboutUtils.followUsItems[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                  foregroundColor: AppColors.primaryColor,
                  child: Icon(item.icon),
                ),
                trailing: const Icon(Icons.chevron_right),
                title: Text(item.title),
                onTap: () {
                  vm.onPressed(item.url);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
