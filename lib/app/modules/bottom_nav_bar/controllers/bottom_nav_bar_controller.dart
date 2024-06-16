import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';

class BottomNavBarController extends GetxController {
  var currentIndex = 0.obs;
  final textEditingController = TextEditingController();

  final List<Widget> pages = [
    const HomeView(),
    const ProfileView(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }

  void handleCreateTodo() {
    // Your logic to handle creating a new todo
  }
}
