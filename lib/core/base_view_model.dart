import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  final BuildContext Function()? getContext;

  BaseViewModel({this.getContext});
}
