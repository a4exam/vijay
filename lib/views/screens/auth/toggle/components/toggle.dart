import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/views/screens/auth/toggle/toggle_utils.dart';

class Toggle extends StatefulWidget {
  const Toggle({
    super.key,
    required this.onChange,
    required this.selectedToggle,
  });

  final Function(ToggleSelection) onChange;
  final ToggleSelection selectedToggle;

  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  late ToggleSelection selectedToggle;

  void onTabToggleItem(val) {
    if (val == selectedToggle) {
      return;
    }
    setState(() {
      selectedToggle = val;
      widget.onChange(selectedToggle);
    });
  }

  @override
  void initState() {
    selectedToggle = widget.selectedToggle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5),
          width: Get.width * 0.8,
          height: Get.height * .07,
          decoration: BoxDecoration(
              color: AppColors.unselectedToggle,
              borderRadius: BorderRadius.circular(25.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onTabToggleItem(ToggleSelection.login),
                  child: Container(
                    padding: const EdgeInsets.all(7.0),
                    decoration: BoxDecoration(
                      color: selectedToggle == ToggleSelection.login
                          ? Colors.white
                          : AppColors.unselectedToggle,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: selectedToggle == ToggleSelection.login
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onTabToggleItem(ToggleSelection.resignation),
                  child: Container(
                    padding: const EdgeInsets.all(7.0),
                    decoration: BoxDecoration(
                      color: selectedToggle == ToggleSelection.login
                          ? AppColors.unselectedToggle
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'Resignation',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: selectedToggle == ToggleSelection.login
                            ? FontWeight.normal
                            : FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
