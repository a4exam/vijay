import 'package:flutter/material.dart';
import 'package:mcq/models/chip_items.dart';
import 'package:mcq/utils/filter_data.dart';
import 'package:mcq/views/components/bottom_sheet_content.dart';
import 'package:sizer/sizer.dart';

import 'chip_widget.dart';

class QuestionFilter extends StatefulWidget {
  final List<String> selectedFilter;
  Function(List<String>) callback;

  QuestionFilter({
    super.key,
    required this.selectedFilter,
    required this.callback,
  });

  @override
  State<QuestionFilter> createState() => _QuestionFilterState();
}

class _QuestionFilterState extends State<QuestionFilter> {

  List<String> tempSelectedFilter = [];

  @override
  void initState() {
    super.initState();
    tempSelectedFilter = widget.selectedFilter;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetContent(
      title: 'Question Filter',
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                constraints: BoxConstraints(maxHeight: 90.h, minHeight: 50.h),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filterData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            filterData[index].mainTitle!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Wrap(
                            spacing: 8.0, // gap between adjacent chips
                            runSpacing: 4.0, // gap between lines
                            children: [
                              ...generateTags(
                                filterData[index].filterValue!,
                                filterData[index].id!,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side:
                                BorderSide(color: Colors.black.withOpacity(0.2)),
                          ),
                        ),
                        onPressed: () {
                          tempSelectedFilter.clear();
                          widget.callback(tempSelectedFilter);
                          setState(() {});
                        },
                        child: const Text(
                          'Clear All',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          widget.callback(tempSelectedFilter);
                          Navigator.pop(context);
                        },
                        child: Text('Apply Filters'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> generateTags(List<ChipClass> filterValue, int mainID) {
    return filterValue
        .map((tag) => ChipWidget(
              data: tag,
              mainID: mainID,
              isSelected: tempSelectedFilter.contains("$mainID-${tag.id}"),
              onTap: () {
                if (tempSelectedFilter.contains("$mainID-${tag.id}")) {
                  tempSelectedFilter.remove("$mainID-${tag.id}");
                } else {
                  tempSelectedFilter.add("$mainID-${tag.id}");
                }
                setState(() {});
              },
            ))
        .toList();
  }
}
