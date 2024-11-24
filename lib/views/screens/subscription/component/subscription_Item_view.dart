import 'package:flutter/material.dart';
import 'package:mcq/themes/color.dart';

class SubscriptionItemBuilder extends StatelessWidget {
  const SubscriptionItemBuilder({super.key, required this.isSelected});
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var colors = [
      Colors.grey,
      Colors.blue.shade50,
    ];
    if (isSelected) {
      colors = [
        AppColors.primaryColor,
        Colors.blue.shade50,
      ];
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: colors)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Subject name ",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 9),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Diamond',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                    fontSize: 17),
              ),
              Text(
                'Rs 499',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 17),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Purchase Date',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              Text('2022-12-22'),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Expiry Date',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              Text('2022-12-22'),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Remaining date',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              Text('133'),
            ],
          ),
        ],
      ),
    );
  }
}
