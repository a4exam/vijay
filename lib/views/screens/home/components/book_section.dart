import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/views/screens/home/home_utils.dart';

class BookSection extends StatelessWidget {
  final BookItemList data;
  final Function(Screens) onPressed;

  const BookSection({
    super.key,
    required this.onPressed,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: data.backgroundColor,
      ),
      child: InkWell(
        onTap: () {
          onPressed(data.screenName);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              height: Get.height*0.10,
              image: AssetImage(data.imagePath),
            ),
            Text(
              data.title,
              style: TextStyle(
                fontSize: Get.height *.03,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Text(
                data.subTitle,
                style: TextStyle(
                  fontSize: Get.height *.02,
                  color: const Color.fromARGB(133, 94, 92, 92),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
