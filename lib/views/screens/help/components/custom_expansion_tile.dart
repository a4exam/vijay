import 'package:flutter/material.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/utils/utils.dart';

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final String body;

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xfff4f8fe),
      elevation: AppElevations.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: _isExpanded ? AppColors.primaryColor : Colors.transparent,
          // Set the border color
          width: 1.0, // Set the border width
        ),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            title: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: _isExpanded
                ? CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(
                      Icons.expand_less,
                    ))
                : const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.chevron_right,
                    )),
          ),
          _isExpanded ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.body,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
