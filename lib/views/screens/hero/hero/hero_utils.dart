import 'package:flutter/material.dart';

class HeroUtils {
  static List<PopupMenuEntry<String>> menuItems(context) {
    return [
      const PopupMenuItem<String>(
        enabled: false,
        child: Text('Sort By'),
      ),
      const PopupMenuItem<String>(
        value: 'Default',
        child: Text('Default'),
      ),
      const PopupMenuDivider(),
      const PopupMenuItem<String>(
        value: 'Old View',
        child: Text('Old View'),
      ),
      const PopupMenuItem<String>(
        value: 'Latest View',
        child: Text('Latest View'),
      ),
      const PopupMenuDivider(),
      const PopupMenuItem<String>(
        value: 'Largest File',
        child: Text('Largest First'),
      ),
      const PopupMenuItem<String>(
        value: 'Smallest File',
        child: Text('Smallest First'),
      ),
    ];
  }

  static final subjects = [
    "Hindi",
    "English",
    "Math",
    "Reasoning",
    "GS",
  ];
}
