import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/utils/utils.dart';
import 'package:mcq/views/components/bottom_sheet_content.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/drop_down/dropdown_view_model.dart';

class DropDownContent extends StatefulWidget {
  final DropdownViewModel vm;

  const DropDownContent({
    super.key,
    required this.vm,
  });

  @override
  State<DropDownContent> createState() => _DropDownContentState();
}

class _DropDownContentState extends State<DropDownContent> {
  @override
  Widget build(BuildContext context) {
    return BottomSheetContent(
      title: widget.vm.title,
      height: widget.vm.height,
      child: Column(
        children: [
          const SizedBox(height: 10),
          searchView(),
          const SizedBox(height: 10),
          listView(),
          CustomButton(
            margin: const EdgeInsets.only(bottom: 10),
            width: Get.width * .9,
            title: "Submit",
            onPressed: widget.vm.onPressedSubmitBtn,
          ),
        ],
      ),
    );
  }

  searchView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: Get.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xfff3f5f8),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            focusColor: AppColors.primaryColor,
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            hintText: "Search",
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            border: OutlineInputBorder(
              borderRadius: AppBorderRadius.textFormFieldBorderRadius,
            ),
          ),
          onChanged: widget.vm.onChangeSearchText,
        ),
      ),
    );
  }

  listView() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(
          () {
            return ListView.builder(
              itemCount: widget.vm.filterList.length,
              itemBuilder: (context, index) {
                final item = widget.vm.filterList[index];
                return Obx(
                  () {
                    final isSelected = widget.vm.selectedList.contains(item);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: ListTile(
                        leading: widget.vm.isShowImage && item.img != null
                            ? Image.network(
                                'https://examopd.com/upload/1705817656-wedding-khyber-hotel.jpg',
                                // URL to your image
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              )
                            : null,
                        title: Text(
                          item.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                        trailing: trailingView(isSelected),
                        onTap: () => widget.vm.onPressedItem(item, !isSelected),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  trailingView(isSelected) {
    return isSelected
        ? SizedBox(
            width: 25,
            height: 25,
            child: CircleAvatar(
              backgroundColor: AppColors.primaryColor.withOpacity(.5),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        : SizedBox(
            width: 20,
            height: 20,
            child: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              child: const Padding(
                padding: EdgeInsets.all(0.8),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          );
  }
}
