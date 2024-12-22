import 'package:carousel_slider/carousel_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nusa_wash_laundry/app/data/model/order.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  int current = 0;
  bool isLoading = false;
  bool isLoadingUser = false;
  bool status = false;
  OrderLaundry? order; // To store a single order object
  late User user;

  String? name;
  String? email;
  String? phone;
  String? profileImageUrl;

  final List<String> listImage = [
    'assets/images/laundry1.png',
    'assets/images/laundry2.png',
    'assets/images/laundry3.jpeg',
  ];

  @override
  void onInit() {
    super.onInit();
    // if (order == null) {
    //   // Fetch the order only if it's null
    //   getOrder();
    //   getUserData();
    // }
    WidgetsBinding.instance.addPostFrameCallback((_) => getUserData());
    WidgetsBinding.instance.addPostFrameCallback((_) => getOrder());
    getOrder();
    getUserData();
  }

  @override
  void onReady() {
    super.onReady();
    getUserData();
    getOrder();
  }

  Future<void> getUserData() async {
    try {
      isLoadingUser = true;
      update();

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        // Convert DocumentSnapshot to Map<String, dynamic>
        Map<String, dynamic> data =
            userData.data() as Map<String, dynamic>? ?? {};

        // Check if the document exists
        if (userData.exists) {
          name = data['name'] ?? '';
          email = user.email ?? '';

          // Check for phone number
          if (data.containsKey('phone')) {
            phone = data['phone'];
          } else {
            phone = null; // Handle case where 'phone' is not provided
          }

          // Check for profile image URL
          if (data.containsKey('photoUrl')) {
            profileImageUrl = data['photoUrl'];
          } else {
            profileImageUrl =
                null; // Handle case where 'photoUrl' is not provided
          }
        } else {
          // Handle case where document does not exist
          name = '';
          email = '';
          phone = null;
          profileImageUrl = null;
        }
      }
      update();
    } catch (e) {
      print('Error getting profile data: $e');
      // Handle error appropriately, e.g., show snackbar or log error
    } finally {
      isLoadingUser = false;
      update();
    }
  }

  void onPageChanged(int index) {
    current = index;
    update();
  }

  Future<void> getOrder() async {
    try {
      isLoading = true;
      update();

      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch orders from Firestore
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('orders')
            .where('userId', isEqualTo: user.uid)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // Assuming only one order per user for simplicity
          order = OrderLaundry.fromFirestore(querySnapshot.docs.first);
          if (order!.status == 'waiting accept') {
            status = true;
          } else {
            status = false;
          }
          update();
        }
      }
    } catch (e) {
      print('Error getting order: $e');
      Get.snackbar('Error', 'Failed to fetch order');
    } finally {
      isLoading = false;
      update();
    }
  }

  void increment() => count.value++;

  void onPageChangedCarousel(int index, CarouselPageChangedReason reason) {
    current = index;
    update();
  }
}
// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:nusa_wash_laundry/app/data/model/order.dart';

// class HomeController extends GetxController {
//   final count = 0.obs;
//   int current = 0;
//   bool isLoading = false;
//   bool isLoadingUser = false;
//   bool status = false;
//   OrderLaundry? order;
//   late User user;

//   String? name;
//   String? email;
//   int? phone;
//   String? profileImageUrl;

//   late StreamController<Map<String, dynamic>> userDataStream;
//   late StreamController<OrderLaundry?> orderStream;

//   final List<String> listImage = [
//     'assets/images/laundry1.png',
//     'assets/images/laundry2.png',
//     'assets/images/laundry3.jpeg',
//   ];

//   @override
//   void onInit() {
//     super.onInit();
//     userDataStream = StreamController<Map<String, dynamic>>.broadcast();
//     orderStream = StreamController<OrderLaundry?>.broadcast();
//     getUserData();
//     getOrder();
//   }

//   @override
//   void onClose() {
//     userDataStream.close();
//     orderStream.close();
//     super.onClose();
//   }

//   void updateUserDataStream(Map<String, dynamic> data) {
//     userDataStream.add(data);
//   }

//   void updateOrderStream(OrderLaundry? order) {
//     orderStream.add(order);
//   }

//   Future<void> getUserData() async {
//     try {
//       isLoadingUser = true;
//       update();

//       User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         DocumentSnapshot userData = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .get();

//         Map<String, dynamic> data =
//             userData.data() as Map<String, dynamic>? ?? {};

//         if (userData.exists) {
//           name = data['name'] ?? '';
//           email = user.email ?? '';

//           if (data.containsKey('phone')) {
//             phone = data['phone'];
//           } else {
//             phone = null;
//           }

//           if (data.containsKey('photoUrl')) {
//             profileImageUrl = data['photoUrl'];
//           } else {
//             profileImageUrl = null;
//           }
//         } else {
//           name = '';
//           email = '';
//           phone = null;
//           profileImageUrl = null;
//         }

//         updateUserDataStream({
//           'name': name,
//           'email': email,
//           'phone': phone,
//           'profileImageUrl': profileImageUrl,
//         });
//         update();
//       }
//     } catch (e) {
//       print('Error getting profile data: $e');
//     } finally {
//       isLoadingUser = false;
//       update();
//     }
//   }

//   Future<void> getOrder() async {
//     try {
//       isLoading = true;
//       update();

//       User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//             .collection('orders')
//             .where('userId', isEqualTo: user.uid)
//             .get();

//         if (querySnapshot.docs.isNotEmpty) {
//           order = OrderLaundry.fromFirestore(querySnapshot.docs.first);
//           if (order!.status == 'waiting accept') {
//             status = true;
//           } else {
//             status = false;
//           }
//           updateOrderStream(order);
//         }
//         update();
//       }
//     } catch (e) {
//       print('Error getting order: $e');
//     } finally {
//       isLoading = false;
//       update();
//     }
//   }

//   void onPageChanged(int index) {
//     current = index;
//     update();
//   }

//   void onPageChangedCarousel(int index, CarouselPageChangedReason reason) {
//     current = index;
//     update();
//   }
// }
