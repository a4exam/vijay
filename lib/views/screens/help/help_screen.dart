import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/views/components/loading_overlay.dart';
import 'package:mcq/views/screens/help/help_view_model.dart';
import 'package:mcq/views/screens/help/tabs_screen/back_call_screen.dart';
import 'package:mcq/views/screens/help/tabs_screen/faq_screen.dart';

class HelpScreen extends StatefulWidget {
  final HelpViewModel vm;

  const HelpScreen({
    super.key,
    required this.vm,
  });

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    widget.vm.setTabController(this);
    return LoadingOverView(
      loading: widget.vm.loading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Help'),
          actions: [
            Obx(
              () => Visibility(
                visible: widget.vm.visibilityOfLanguageBtn.value,
                child: IconButton(
                  onPressed: widget.vm.setLanguage,
                  icon: const Icon(Icons.translate),
                ),
              ),
            )
          ],
          bottom: TabBar(
            controller: widget.vm.tabController,
            tabs: const [
              Tab(
                icon: Icon(Icons.question_answer),
                text: 'FAQ',
              ),
              Tab(
                icon: Icon(Icons.call),
                text: 'Back Call',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: widget.vm.tabController,
          children: [
            Obx(
              () => FaqScreen(
                faqListItem: widget.vm.faqListItem.value,
                isLanguageEn: widget.vm.isLanguageEn.value,
              ),
            ),
            BackCallScreen(vm: widget.vm),
          ],
        ),
      ),
    );
  }
}
