import 'package:flutter/material.dart';

class ScoreSummaryRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? additionalInfo;
  final Color color;
  final Color iconColor;

  const ScoreSummaryRow({super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.additionalInfo,
    required this.color, required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 25,
          child: Icon(icon, color: iconColor),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            if (additionalInfo != null)
              Text(
                additionalInfo!,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
          ],
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}