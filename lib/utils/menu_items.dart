import 'package:flutter/material.dart';

List<PopupMenuEntry<String>> buildPopupMenuItems() {
  return [
    const PopupMenuItem<String>(
      value: 'Default',
      child: Text('Default'),
    ),
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
      child: Text('Largest File'),
    ),
    const PopupMenuItem<String>(
      value: 'Smallest File',
      child: Text('Smallest File'),
    ),
  ];
}