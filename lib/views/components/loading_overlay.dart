import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/color.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    this.isLoading = false,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          AbsorbPointer(
            absorbing: true, // Prevent interaction with the child widget
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            ),
          ),
      ],
    );
  }
}

class LoadingOverView extends StatelessWidget {
  const LoadingOverView({
    super.key,
    required this.loading,
    required this.child,
  });

  final RxBool loading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Obx(() => loading.value
            ? AbsorbPointer(
                absorbing: true,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink())
      ],
    );
  }
}
