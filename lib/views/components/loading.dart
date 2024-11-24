import 'package:flutter/material.dart';
import 'package:mcq/themes/color.dart';

class LoadingView extends StatelessWidget {
  final bool loading;

  const LoadingView({
    super.key,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return AbsorbPointer(
        absorbing: true, // Prevent interaction with the child widget
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
