import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:nusa_wash_laundry/app/modules/bottom_nav_bar/views/bottom_nav_bar_view.dart';
import 'package:nusa_wash_laundry/app/modules/home/controllers/home_controller.dart';
import 'package:nusa_wash_laundry/app/widgets/custom_text_field.dart';

class PaymentController extends GetxController {
  bool isLoadingLaundry = false;

  var pickedBirthDate = Rx<DateTime?>(null);
  var pickedTime = Rx<TimeOfDay?>(null);
  TextEditingController birthDatePickedController = TextEditingController();
  TextEditingController timePickedController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  late User user;

  // String? name;
  // String? email;
  // int? phone;
  // String? profileImageUrl; // Add this line to store profile image URL

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) => getUserData());

    user = FirebaseAuth.instance.currentUser!;
    getUserData();
  }

  @override
  void onReady() {
    super.onReady();
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      isLoading = true;
      update();

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        update();

        // Convert DocumentSnapshot to Map<String, dynamic>
        Map<String, dynamic> data =
            userData.data() as Map<String, dynamic>? ?? {};
        print(userData);

        // Check if the document exists
        if (userData.exists) {
          nameController.text = data['name'] ?? '';
          phoneController.text = '0${data['phone']}';
          // emailcon = user.email ?? '';
          update();
        } else {
          // Handle case where document does not exist
          nameController.text = '';
          phoneController.text = '';

          update();
        }
      }
      update();
    } catch (e) {
      print('Error getting profile data: $e');
      // Handle error appropriately, e.g., show snackbar or log error
    } finally {
      isLoading = false;
      update();
    }
  }

  void saveOrderToFirestore({
    required bool isCuciLipat,
    required bool isCuciSetrika,
    required double totalPrice,
    required double quantity,
    required String additionalNote,
  }) async {
    try {
      isLoadingLaundry = true;
      update();

      // Ambil reference collection 'orders' di Firestore
      CollectionReference orders =
          FirebaseFirestore.instance.collection('orders');

      // Ambil data dari Form
      String name = nameController.text;
      String phone = phoneController.text;
      String address = addressController.text;
      String houseNumber = houseNumberController.text;

      // Ambil user saat ini dari FirebaseAuth
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'User tidak ditemukan');
        return;
      }

      // Simpan data ke Firestore dengan ID user sebagai ID dokumen
      await orders.doc(user.uid).set({
        'userId': user.uid, // ID pengguna sebagai ID dokumen
        'name': name,
        'phone': phone,
        'address': address,
        'houseNumber': houseNumber,
        'isCuciLipat': isCuciLipat,
        'isCuciSetrika': isCuciSetrika,
        'totalPrice': totalPrice,
        'quantity': quantity,
        'additionalNote': additionalNote,
        'status': 'waiting accept',
        'orderDate': DateTime.now(), // Contoh tanggal pemesanan
      });

      // Tampilkan pesan atau lakukan navigasi setelah berhasil disimpan
      Get.snackbar('Sukses', 'Pesanan telah disimpan');
      // showDialog(
      //   context: Get.context!,
      //   builder: (context) {
      //     // Schedule a delayed dismissal of the alert dialog after 3 seconds
      //     Future.delayed(const Duration(seconds: 2), () {
      //       Navigator.of(context).pop(); // Close the dialog
      //     });

      //     // Return the AlertDialog widget
      //     return const AlertDialog(
      //       title: Text("Auto Dismiss Alert Dialog"),
      //       content:
      //           Text("This alert will dismiss automatically in 3 seconds."),
      //     );
      //   },
      // );
      Get.lazyPut(() => HomeController());
      Get.offAll(() => const BottomNavBarView());
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Gagal menyimpan pesanan');
    } finally {
      isLoadingLaundry = false;
      update();
    }
  }

  bool get isInputValid {
    if (birthDatePickedController.value.text != '' &&
        timePickedController.value.text != '' &&
        nameController.value.text != '' &&
        phoneController.value.text != '' &&
        addressController.value.text != '' &&
        houseNumberController.value.text != '') {
      return true;
    }
    return false;
  }

  void showLaundryTakeUpDatePicker() async {
    final today = DateTime.now();
    final initialDate = pickedBirthDate.value ?? today;

    pickedBirthDate.value = await showDatePicker(
      context: Get.context!,
      initialDate: initialDate.isBefore(today) ? today : initialDate,
      firstDate: today,
      lastDate: DateTime(2100),
      locale: const Locale('id', 'ID'),
    );

    if (pickedBirthDate.value != null) {
      final format = DateFormat('EEEE, dd MMMM yyyy', 'id_ID');
      birthDatePickedController.text = format.format(pickedBirthDate.value!);
      update();
    }
  }

  void showLaundryTakeUpTimePicker() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 280,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TimePickerSpinner(
                  is24HourMode: true,
                  normalTextStyle: const TextStyle(
                    fontSize: 24,
                    color: Colors.black54,
                  ),
                  highlightedTextStyle: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                  spacing: 50,
                  itemHeight: 60,
                  isForce2Digits: true,
                  onTimeChange: (time) {
                    if (time.hour >= 10 && time.hour < 15) {
                      pickedTime.value = TimeOfDay.fromDateTime(time);
                      update();
                    } else {
                      pickedTime.value = null;
                      update();
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (pickedTime.value != null) {
                      final formattedTime = DateFormat('HH:mm').format(
                        DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          pickedTime.value!.hour,
                          pickedTime.value!.minute,
                        ),
                      );
                      timePickedController.text = '$formattedTime WIB';
                      update();
                      Get.back();
                    } else {
                      Get.snackbar('Tidak Bisa',
                          'Antar jemput hanya pada jam 10:00 - 15:00');
                      update();
                    }
                  },
                  child: const Text('Pilih'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showAddressModal() {
    Get.bottomSheet(
      SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Alamat',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'Nama',
                  controller: nameController,
                  textInputType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama harus diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'No Telepon',
                  controller: phoneController,
                  textInputType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nomor telepon harus diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'Alamat',
                  controller: addressController,
                  textInputType: TextInputType.streetAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Alamat harus diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  label: 'Nomor Rumah/Kos',
                  controller: houseNumberController,
                  textInputType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nomor rumah/kos harus diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Colors.lightBlue,
                    ),
                    foregroundColor: MaterialStatePropertyAll<Color>(
                      Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.back();
                      _updateAddressSummary();
                      update(); // Update UI if needed
                    }
                  },
                  child: const Text('Simpan'),
                ),
                // const SizedBox(height: 33),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateAddressSummary() {
    final name = nameController.text;
    final phone = phoneController.text;
    final address = addressController.text;
    final houseNumber = houseNumberController.text;

    final summary =
        'Nama: $name\nNo Telepon: $phone\nAlamat: $address\nNomor Rumah/Kos: $houseNumber';

    // Do something with the summary (e.g., store it or display it)
    print(summary); // Example: Print to console

    // Example: Update UI with summary
    // You can update a text field or any other UI element here
  }
}
