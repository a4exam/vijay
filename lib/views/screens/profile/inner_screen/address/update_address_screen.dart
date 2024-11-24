import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/views/components/bottom_sheet_content.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/custom_text_field.dart';
import 'package:mcq/views/components/drop_down/drop_down.dart';
import 'package:mcq/views/components/drop_down/dropdown_view_model.dart';
import 'package:mcq/views/components/drop_down/drop_down_utils.dart';
import 'package:mcq/views/screens/profile/inner_screen/address/update_address_view_model.dart';

class UpdateAddressScreen extends StatefulWidget {
  const UpdateAddressScreen({super.key, required this.vm});

  final UpdateAddressViewModel vm;

  @override
  State<UpdateAddressScreen> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return BottomSheetContent(
      title: "Update address",
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///Country
              const SizedBox(height: 20),
              DropDown(
                vm: DropdownViewModel(
                  dataList: DropDownUtils.countryItems,
                  controller: widget.vm.countryController,
                  title: "Country",
                  onChanged: widget.vm.onChangedCountry,
                ),
              ),

              ///State
              const SizedBox(height: 20),
              Obx(
                () => DropDown(
                  vm: DropdownViewModel(
                    dataList: widget.vm.stateList.value,
                    controller: widget.vm.stateController,
                    title: "State",
                    onChanged: widget.vm.onChangedState,
                  ),
                ),
              ),

              ///District
              const SizedBox(height: 20),
              Obx(
                () => DropDown(
                  vm: DropdownViewModel(
                    dataList: widget.vm.cityList.value,
                    controller: widget.vm.districtController,
                    title: "District",
                    onChanged: widget.vm.onChangedCity,
                  ),
                ),
              ),

              /// Town
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "Town/Village",
                controller: widget.vm.townVillageController,
              ),

              ///PinCode
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "PinCode",
                controller: widget.vm.pinCodeController,
              ),

              /// Submit
              const SizedBox(height: 30),
              CustomButton(
                title: 'Submit',
                onPressed: widget.vm.onPressedSubmitBtn,
                width: Get.width,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
