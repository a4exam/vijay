import 'package:flutter/material.dart';

class RankTile extends StatelessWidget {
  final String title;
  final int rank;
  final int total;
  final double progress;

  const RankTile({super.key,
    required this.title,
    required this.rank,
    required this.total,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 8.0),
          LinearProgressIndicator(
            value: progress,
            minHeight: 5.0,
            backgroundColor: Colors.grey[300],
            color: Colors.blue,
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$rank Rank",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              Text(
                "out of $total",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}