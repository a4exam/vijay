import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mcq/models/hero/question.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/custom_spacer.dart';
import 'package:mcq/views/screens/hero/question/question_view_model.dart';
import 'package:mcq/views/screens/question_report/question_report.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import 'components/option_view.dart';

enum OptionFlag {
  A,
  B,
  C,
  D;

  String getOptionNumber() {
    switch (this) {
      case OptionFlag.A:
        return "1";
      case OptionFlag.B:
        return "2";
      case OptionFlag.C:
        return "3";
      case OptionFlag.D:
        return "4";
    }
  }
}
