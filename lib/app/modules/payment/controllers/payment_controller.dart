import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:nusa_wash_laundry/app/widgets/custom_text_field.dart';

class PaymentController extends GetxController {
  bool isLoading = false;

  var pickedBirthDate = Rx<DateTime?>(null);
  var pickedTime = Rx<TimeOfDay?>(null);
  TextEditingController birthDatePickedController = TextEditingController();
  TextEditingController timePickedController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void saveOrderToFirestore({
    required bool isCuciLipat,
    required bool isCuciSetrika,
    required double totalPrice,
    required double quantity,
    required String additionalNote,
  }) async {
    try {
      isLoading = true;
      update();
      // Ambil reference collection 'orders' di Firestore
      CollectionReference orders =
          FirebaseFirestore.instance.collection('orders');

      // Ambil data dari PaymentController
      String name = nameController.text;
      String phone = phoneController.text;
      String address = addressController.text;
      String houseNumber = houseNumberController.text;

      // Simpan data ke Firestore
      await orders.add({
        'name': name,
        'phone': phone,
        'address': address,
        'houseNumber': houseNumber,
        'isCuciLipat': isCuciLipat,
        'isCuciSetrika': isCuciSetrika,
        'totalPrice': totalPrice,
        'quantity': quantity,
        'additionalNote': additionalNote,
        'orderDate': DateTime.now(), // Contoh tanggal pemesanan
        'orderTime': TimeOfDay.now(), // Contoh jam pemesanan
        // Tambahkan data lainnya sesuai kebutuhan
      });

      // Tampilkan pesan atau lakukan navigasi setelah berhasil disimpan
      Get.snackbar('Sukses', 'Pesanan telah disimpan');
      // Misalnya navigasi ke halaman lain setelah simpan berhasil
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HalamanBerhasil()));
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Gagal menyimpan pesanan');
    } finally {
      isLoading = false;
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

  // void showLaundryTakeUpTimePicker() {
  //   showDialog(
  //     context: Get.context!,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         child: Container(
  //           height: 280,
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             children: [
  //               TimePickerSpinner(
  //                 is24HourMode: true,
  //                 normalTextStyle: const TextStyle(
  //                   fontSize: 24,
  //                   color: Colors.black54,
  //                 ),
  //                 highlightedTextStyle: const TextStyle(
  //                   fontSize: 24,
  //                   color: Colors.black,
  //                 ),
  //                 spacing: 50,
  //                 itemHeight: 60,
  //                 isForce2Digits: true,
  //                 onTimeChange: (time) {
  //                   if (time.hour >= 10 && time.hour < 15) {
  //                     pickedTime.value = TimeOfDay.fromDateTime(time);
  //                     update();
  //                   } else {
  //                     pickedTime.value = null;
  //                     update();
  //                   }
  //                 },
  //               ),
  //               const SizedBox(height: 20),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   if (pickedTime.value != null) {
  //                     final formattedTime = DateFormat('HH:mm').format(
  //                       DateTime(
  //                         DateTime.now().year,
  //                         DateTime.now().month,
  //                         DateTime.now().day,
  //                         pickedTime.value!.hour,
  //                         pickedTime.value!.minute,
  //                       ),
  //                     );
  //                     timePickedController.text = '$formattedTime WIB';
  //                     update();
  //                     Get.back();
  //                   } else {
  //                     Get.snackbar('Tidak Bisa',
  //                         'Antar jemput hanya pada jam 10:00 - 15:00');
  //                     update();
  //                   }
  //                 },
  //                 child: const Text('Pilih'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  void showLaundryTakeUpTimePicker() {
    DateTime today = DateTime.now();
    DateTime initialDateTime = pickedBirthDate.value ?? today;

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
                    DateTime selectedDateTime = DateTime(
                      initialDateTime.year,
                      initialDateTime.month,
                      initialDateTime.day,
                      time.hour,
                      time.minute,
                    );

                    if (pickedBirthDate.value == null ||
                        pickedBirthDate.value!.isAfter(today)) {
                      // No validation needed if the picked date is tomorrow or later
                      pickedTime.value =
                          TimeOfDay.fromDateTime(selectedDateTime);
                      update();
                      return;
                    }

                    // Validate time for today's pickup
                    if (selectedDateTime
                        .isAfter(today.add(const Duration(hours: 1)))) {
                      // Valid time today (at least 1 hour later than now)
                      if (selectedDateTime.hour >= 10 &&
                          selectedDateTime.hour < 15) {
                        pickedTime.value =
                            TimeOfDay.fromDateTime(selectedDateTime);
                        update();
                      } else {
                        pickedTime.value = null;
                        Get.snackbar(
                          'Tidak Bisa',
                          'Antar jemput hanya pada jam 10:00 - 15:00',
                        );
                        update();
                      }
                    } else {
                      // Time is too soon for today, redirect to tomorrow
                      Get.snackbar(
                        'Perhatian',
                        'Pemesanan lebih dari jam 14:00 akan dialihkan ke besok hari.',
                      );
                      pickedBirthDate.value =
                          today.add(const Duration(days: 1));
                      pickedTime.value = const TimeOfDay(hour: 10, minute: 0);
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
                          initialDateTime.year,
                          initialDateTime.month,
                          initialDateTime.day,
                          pickedTime.value!.hour,
                          pickedTime.value!.minute,
                        ),
                      );
                      timePickedController.text = '$formattedTime WIB';
                      update();
                      Get.back();
                    } else {
                      Get.snackbar(
                        'Tidak Bisa',
                        'Antar jemput hanya pada jam 10:00 - 15:00',
                      );
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
