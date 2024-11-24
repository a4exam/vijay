import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageSlider extends StatefulWidget {
  final List<String> imageList;

  const ImageSlider({super.key, required this.imageList});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<Widget> imageSliders = [];

  @override
  void initState() {
    imageSliders = widget.imageList
        .map((item) => Container(
              margin: EdgeInsets.only(
                top: Get.height * 0.006,
                bottom: Get.height * 0.006,
                left: Get.width * 0.001,
                right: Get.width * 0.001,
              ),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        item,
                        fit: BoxFit.cover,
                        width: Get.width * 2.5,
                      ),
                    ],
                  )),
            ))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: imageSliders,
      options: CarouselOptions(
        height: Get.height * 0.16,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
      ),
    );
  }
}
