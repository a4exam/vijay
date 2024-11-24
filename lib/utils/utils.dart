import 'package:flutter/material.dart';

class AppBorderRadius {
  static final textFormFieldBorderRadius = BorderRadius.circular(22.0);
  static final containerShape = BorderRadius.circular(10.0);
}

class AppShapes {
  static final cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  );
  static final cardShapeLarge = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(40.0),
  );

}

class AppElevations {
  static const double cardElevation = 5.0;
  static const double cardElevationLarge = 10.0;
}
