import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/checkScore/omrsheet.dart';
import 'package:mcq/checkScore/reusable_widget.dart';

import '../themes/color.dart';
import '../views/components/drop_down/drop_down.dart';
import '../views/components/drop_down/drop_down_utils.dart';
import '../views/components/drop_down/dropdown_view_model.dart';
import '../views/screens/checkScrore/checkscore_view_model.dart';

class AdmitCard extends StatefulWidget {
  const AdmitCard({super.key});

  @override
  State<AdmitCard> createState() => _AdmitCardState();
}

class _AdmitCardState extends State<AdmitCard> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _admitCard = TextEditingController();
  final TextEditingController _paperShite = TextEditingController();
  String? _gender;
  String? _category;
  String? _horizontalReservation; // Change to String
  String? _state;
  String? _district;
  File? selectedFile;
  final vm = Get.put(CheckScoreViewModel());

  bool isSubmitEnabled = false;

  @override
  void initState() {
    super.initState();
    vm.init();
    _admitCard.addListener(_validateForm);
    _paperShite.addListener(_validateForm);
    _state = null; // Reset state when initializing
    _district = null; // Reset district when initializing
    _horizontalReservation = null; // Reset horizontal reservation when initializing
  }

  @override
  void dispose() {
    _admitCard.dispose();
    _paperShite.dispose();
    super.dispose();
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
        _admitCard.text = result.files.single.name;
        _validateForm();
      });
    }
  }

  void _validateForm() {
    setState(() {
      isSubmitEnabled = selectedFile != null &&
          _admitCard.text.isNotEmpty &&
          _paperShite.text.isNotEmpty &&
          _gender != null &&
          _category != null &&
          _horizontalReservation != null &&
          _state != null &&
          _district != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Exam name',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .90,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const Text(
                    'Please Upload Admit Card',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    readOnly: true,
                    controller: _admitCard,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: pickFile,
                        child: const Icon(Icons.attach_file_outlined),
                      ),
                      hintText: "Upload Admit Card",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  reusableTextField('Paper Shift', null, false, _paperShite),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: _gender,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    hint: const Text('Select Gender'),
                    items: <String>['Male', 'Female', 'Other'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _gender = newValue;
                        _validateForm();
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: _category,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    hint: const Text('Select Category'),
                    items: <String>[
                      'General', 'OBC', 'EWS', 'SC', 'ST',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _category = newValue;
                        _validateForm();
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: DropdownButton<String>(
                      padding: const EdgeInsets.only(right: 8),
                      value: _horizontalReservation,
                      hint: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Select Horizontal Reservation'),
                      ),
                      items: <String>[
                        'None', 'OH', 'VH', 'HH', 'Ex-ServiceMan'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _horizontalReservation = newValue;
                          _validateForm();
                        });
                      },
                      isExpanded: true,
                      underline: SizedBox(), // Hide the default underline
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DropdownButton<String>(
                        padding: const EdgeInsets.only(right: 8),
                        value: _state,
                        hint: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text('Select State'),
                        ),
                        items: vm.stateDistrictMap.keys.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _state = newValue;
                            _district = null; // Reset district when state changes
                            _validateForm();
                          });
                        },
                        isExpanded: true, // Ensures the dropdown button takes full width
                        underline: const SizedBox(), // Hide the default underline
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  if (_state != null)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: DropdownButton<String>(
                          value: _district,
                          hint: const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text('Select District'),
                          ),
                          items: vm.stateDistrictMap[_state]!.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _district = newValue;
                              _validateForm();
                            });
                          },
                          isExpanded: true,
                          underline: const SizedBox(), // Hide the default underline
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () async {
                      if (isSubmitEnabled) {
                        final int paperShift = int.tryParse(_paperShite.text) ?? 0;

                        // Show loading dialog
                        Get.dialog(
                          Center(child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          )),
                          barrierDismissible: false,
                        );

                        try {
                          // Call the upload function
                          await vm.uploadAdmitCard(
                            paperShift,
                            _gender ?? '',
                            _category ?? '',
                            _horizontalReservation ?? '',
                            _state ?? '',
                            _district ?? '',
                            selectedFile,
                          );

                          // Close the loading dialog
                          Get.back();

                          // Show success message
                          Get.snackbar("Success", "Admit card uploaded successfully!",
                              backgroundColor: Colors.green, colorText: Colors.white);

                          // Reset form fields
                          _admitCard.clear();
                          _paperShite.clear();
                          _gender = null;
                          _category = null;
                          _horizontalReservation = null;
                          _state = null;
                          _district = null;
                          selectedFile = null;

                          _validateForm(); // Update the state for UI changes
                          isSubmitEnabled==false;
                        } catch (error) {
                          // Close the loading dialog
                          Get.back();

                          // Show error message
                          Get.snackbar("Error", "Failed to upload admit card.",
                              backgroundColor: Colors.red, colorText: Colors.white);
                        }
                      } else {
                        Get.snackbar(
                          "",
                          "",
                          backgroundColor: AppColors.primaryColor,
                          titleText: const Center(
                            child: Text(
                              "Required fields cannot be empty!",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primaryColor,
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Submit", style: TextStyle(
                              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700
                          )),
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
