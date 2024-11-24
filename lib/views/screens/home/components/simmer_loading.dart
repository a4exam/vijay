import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeSimmerLoading extends StatelessWidget {
  const HomeSimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.25),
      highlightColor: Colors.white.withOpacity(0.6),
      period: const Duration(seconds: 2),
      direction: ShimmerDirection.ltr,
      child: ListView(
        children: [
          const SizedBox(height: 10),
          CarouselSlider(
            options: CarouselOptions(
              height: Get.height * 0.16,

              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
            ),
            items: [
              Container(
                height: Get.height * 0.16,
                width: Get.width * 0.80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 32.0),
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.2,
              vertical: Get.height * 0.1,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 207, 204, 204),
            ),
          ),
          const SizedBox(height: 10),
          GridView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: .8,
            ),
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
              ),
            ],
          ),
           SizedBox(height: Get.height * .1),
        ],
      ),
    );
  }
}
