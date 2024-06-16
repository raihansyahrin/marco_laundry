import 'package:carousel_slider/carousel_slider.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nusa_wash_laundry/app/common/theme/font.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
        return ColorfulSafeArea(
          color: Colors.lightBlue.withOpacity(0.35),
          child: Scaffold(
            backgroundColor: Colors.lightBlue.withOpacity(0.35),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const TextField(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/LogoNusaWash.png',
                          height: 50,
                        ),
                        const Text('Raihan')
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 248, 253, 255),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: _buildImageBannerCarousel(
                            current: controller.current,
                            imageList: controller.listImage,
                            onPageChanged: controller.onPageChangedCarousel,
                          ),
                        ),
                        // Positioned(
                        //   top: 0,
                        //   child: Container(
                        //     height: 300,
                        //     width:
                        //         MediaQuery.of(context).size.width, // Use full width
                        //     decoration: const BoxDecoration(
                        //       color: Colors.red,
                        //       borderRadius: BorderRadius.vertical(
                        //         top: Radius.circular(20),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageBannerCarousel({
    required int current,
    required List<String> imageList,
    required void Function(int index, CarouselPageChangedReason reason)
        onPageChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nusa Wash Laundry',
          style: semiBoldText16.copyWith(
            color: Colors.lightBlue,
          ),
        ),
        Stack(
          children: [
            _buildImageSlider(
              current: current,
              imageList: imageList,
              onPageChanged: onPageChanged,
            ),
            _buildDotSlider(
              current: current,
              imageList: imageList,
            ),
          ],
        ),
      ],
    );
  }

  _buildImageSlider({
    required int current,
    required List<String> imageList,
    required void Function(int index, CarouselPageChangedReason reason)
        onPageChanged,
  }) {
    return CarouselSlider(
      options: CarouselOptions(
        clipBehavior: Clip.none,
        height: MediaQuery.of(Get.context!).size.width * 9 / 16,
        viewportFraction: 0.98,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        onPageChanged: onPageChanged,
      ),
      items: imageList.map(
        (i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(i),
                  ),
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }

  _buildDotSlider({
    required int current,
    required List<String> imageList,
  }) {
    return Positioned(
      bottom: 8.0,
      right: 16.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: imageList.map((url) {
          int index = imageList.indexOf(url);
          return Row(children: [
            index == current ? _buildDotWithProgress() : _buildDot(),
            if (index < imageList.length - 1) const SizedBox(width: 4),
          ]);
        }).toList(),
      ),
    );
  }

  _buildDotWithProgress() {
    return SizedBox(
      width: 24.0,
      height: 8.0,
      child: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: TweenAnimationBuilder<double?>(
          duration: const Duration(seconds: 5),
          tween: Tween<double?>(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return LinearProgressIndicator(
              minHeight: 8.0,
              backgroundColor: Colors.white.withOpacity(0.8),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
              value: value ?? 0.0,
              borderRadius: BorderRadius.circular(10),
            );
          },
        ),
      ),
    );
  }

  _buildDot() {
    return Container(
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white.withOpacity(0.8),
      ),
    );
  }
}
