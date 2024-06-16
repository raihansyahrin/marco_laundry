import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  User? user; // Firebase User object

  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Check if user is already signed in
    user = FirebaseAuth.instance.currentUser;
  }

  Future<void> onLoginClicked() async {
    try {
      isLoading = true;
      update();

      // Perform Firebase sign in
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // Update local user object
      user = userCredential.user;

      // Navigate to home or profile screen
      Get.offAllNamed('/home'); // Change '/home' to your desired route
    } catch (e) {
      print('Error: $e');
      // Handle login errors
    } finally {
      isLoading = false;
      update(); // Set isLoading to false when login process ends (success or error)
    }
  }
}
