
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcq/views/components/dropdown/dropdown_alert.dart';
import 'package:mcq/views/components/drop_down/drop_down_utils.dart';
import 'package:mcq/utils/dropdown_data.dart';
import 'package:provider/provider.dart';
import 'package:mcq/view_models/dark_theme_provider.dart';
import 'font_size_dialog.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDark = false;
  var notificationItems = [
    'Push Notification',
    'Vibration',
    'Mute',
  ];

  late String notificationValue;
  late NotificationItems selectedNotificationItem;

  @override
  void initState() {
    super.initState();
    notificationValue = notificationItems[0];
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    var textStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w300,
        );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dark mode ",
                    style: textStyle,
                  ),
                  Switch(
                    value: themeChange.darkTheme,
                    onChanged: (value) async {
                      themeChange.darkTheme = value;
                    },
                  ),
                ],
              ),
              const Divider(),
              ListTileTheme(
                contentPadding: const EdgeInsets.all(0),
                child: ExpansionTile(
                  title: Text(
                    'Notification ',
                    style: textStyle,
                  ),
                  expandedAlignment: Alignment.topLeft,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            RadioListTile<NotificationItems>(
                              title: const Text('Push Notification'),
                              value: NotificationItems.pushNotification,
                              groupValue: selectedNotificationItem,
                              controlAffinity: ListTileControlAffinity.trailing,
                              onChanged: (NotificationItems? value) {
                                setState(() {
                                  selectedNotificationItem = value!;
                                });
                              },
                            ),
                            RadioListTile<NotificationItems>(
                              title: const Text('Vibration'),
                              value: NotificationItems.vibration,
                              groupValue: selectedNotificationItem,
                              controlAffinity: ListTileControlAffinity.trailing,
                              onChanged: (NotificationItems? value) {
                                setState(() {
                                  selectedNotificationItem = value!;
                                });
                              },
                            ),
                            RadioListTile<NotificationItems>(
                              title: const Text('Mute'),
                              value: NotificationItems.mute,
                              groupValue: selectedNotificationItem,
                              controlAffinity: ListTileControlAffinity.trailing,
                              onChanged: (NotificationItems? value) {
                                setState(() {
                                  selectedNotificationItem = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              ListTileTheme(
                contentPadding: const EdgeInsets.all(0),
                child: ExpansionTile(
                  title: Text(
                    'Font',
                    style: textStyle,
                  ),
                  expandedAlignment: Alignment.topLeft,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: openFontStyleDialog,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Font style",
                              style: textStyle,
                            ),
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Font colour",
                            style: textStyle,
                          ),
                        ),
                        const Divider(),
                        InkWell(
                          onTap: () => openFontSizeDialog(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Font Size",
                              style: textStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Background Colour Change",
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double selectedFontSize = 18.0;

  void openFontSizeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FontSizeDialog(
          initialFontSize: selectedFontSize,
          onFontSizeChanged: (double value) {
            selectedFontSize = value;
          },
        );
      },
    );
  }

  void openFontStyleDialog() async {
    final List<DropdownListItem> results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DropdownAlert(
          items: fontStyleItems
              .map((item) => DropdownListItem(title: item, isSelected: false, id: ''))
              .toList(),
          title: "",
          searchable: true,
          selectedItems: [],
        );
      },
    );
    if (results != null) {
      setState(() {
      });
    }
  }
}

enum NotificationItems { pushNotification, vibration, mute }
