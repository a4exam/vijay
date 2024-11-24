import 'package:flutter/material.dart';
import 'package:mcq/models/help/faq_list.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/views/screens/help/components/custom_expansion_tile.dart';

class FaqScreen extends StatefulWidget {
  final FaqListItem? faqListItem;
  bool isLanguageEn = false;

  FaqScreen({
    super.key,
    required this.faqListItem,
    required this.isLanguageEn,
  });

  static const textStyle = TextStyle(
      color: Colors.black87, fontSize: 17, fontWeight: FontWeight.w300);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.faqListItem == null
        ? Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Frequently Asked Questions',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  if (widget.faqListItem != null)
                    ListView.builder(
                        itemCount: widget.faqListItem!.data?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var item = widget.faqListItem!.data?[index];
                          return CustomExpansionTile(
                            title: widget.isLanguageEn
                                ? item!.questionEng!
                                : item!.questionHi!,
                            body: widget.isLanguageEn
                                ? item.solutionEng!
                                : item.solutionHi!,
                          );
                        }),
                ],
              ),
            ),
          );
  }
}
