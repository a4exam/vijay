import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/models/comman/IdName.dart';
import 'package:mcq/models/hero/chapter.dart';
import 'package:mcq/themes/color.dart';

import 'chapter_view.dart';

class BookChapterView extends StatefulWidget {
  final IdName book;
  final Future<List<Chapter>> Function(String) getChapters;
  final Function(Chapter) onPressedChapter;

  const BookChapterView({
    super.key,
    required this.book,
    required this.getChapters,
    required this.onPressedChapter
  });

  @override
  State<BookChapterView> createState() => _BookChapterViewState();
}

class _BookChapterViewState extends State<BookChapterView> {

  bool _isExpanded = false;
  List<Chapter> chapters = [];



  onPressedExpandedButton() async {
    if (_isExpanded) {
      _isExpanded = false;
    } else {
      if (chapters.isEmpty) {
        chapters = await widget.getChapters(widget.book.id!);
      }
      _isExpanded = true;
    }
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant BookChapterView oldWidget) {
    _isExpanded=false;
    chapters=[];
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.book.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              IconButton(
                onPressed: onPressedExpandedButton,
                icon: _isExpanded
                    ? CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        child: const Icon(
                          Icons.expand_less,
                        ))
                    : const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.expand_more,
                        ),
                      ),
              )
            ],
          ),
        ),
        _isExpanded
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: chapters.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final chapter = chapters[index];
                  return ChapterView(
                    chapter:chapter,
                    onPressedChapter: widget.onPressedChapter,
                  );
                },
              )
            : const SizedBox.shrink(),
        Container(
          color: Colors.grey,
          width: Get.width,
          height: 1,
        )
      ],
    );
  }
}
