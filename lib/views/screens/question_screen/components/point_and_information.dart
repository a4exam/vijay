import 'package:flutter/material.dart';

class PointAndInformation extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final String description;

  const PointAndInformation({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(image, height: 40),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 9),
            Text(
              title,
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              subTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              child: Text(
                description,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
