import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/models/comman/IdName.dart';
import 'package:mcq/views/components/loading_overlay.dart';
import 'package:mcq/views/screens/hero/hero/hero_utils.dart';
import 'package:mcq/views/screens/hero/hero/hero_view_model.dart';
import 'package:mcq/views/screens/previous_year/components/subject_selection_button.dart';

import 'components/book_chapter_view.dart';

class HeroScreen extends StatefulWidget {
  const HeroScreen({super.key});

  @override
  State<HeroScreen> createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
  final vm = Get.put(HeroViewModel());

  @override
  Widget build(BuildContext context) {
    return LoadingOverView(
      loading: vm.loading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Hero"),
          actions: [
            PopupMenuButton<String>(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    8.0), // Set the desired border radius here
              ),
              onSelected: vm.setSelectedMenuItem,
              itemBuilder: HeroUtils.menuItems,
            ),
          ],
        ),
        body: Column(
          children: [
            /// Subject button
            SizedBox(
              height: 50,
              child: Obx(
                () => ListView.builder(
                  itemCount: vm.subjects.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(
                      () {
                        final subject = vm.subjects[index];
                        final isSelected =
                            vm.selectedSubject.value?.id == subject.id;
                        return SubjectSelectionButton(
                          isSelected: isSelected,
                          title: subject.name ?? "",
                          onPressed: () => vm.onPressedSubject(
                            isSelected: !isSelected,
                            subject: subject,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Obx(
                  () => ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: vm.books.length,
                    itemBuilder: (context, index) {
                      final book = vm.books[index];
                      return BookChapterView(
                        book: book,
                        getChapters: (bookId) async =>
                            await vm.getChapters(bookId),
                        onPressedChapter: vm.onPressedChapter,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
