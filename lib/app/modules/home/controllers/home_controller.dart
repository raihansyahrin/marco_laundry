import 'package:carousel_slider/carousel_options.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  int current = 0;

  final List<String> listImage = [
    'assets/images/laundry1.png',
    'assets/images/laundry2.png',
    'assets/images/laundry3.jpeg',
  ];

  void increment() => count.value++;

  void onPageChanged(dynamic index) {
    current = index;
    update();
  }

  void onPageChangedCarousel(int index, CarouselPageChangedReason reason) {
    current = index;
    update();
  }
}
