import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nusa_wash_laundry/app/common/theme/font.dart';
import 'package:nusa_wash_laundry/app/widgets/button_bar_total.dart';
import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  final bool isCuciLipat;
  final bool isCuciSetrika;
  final double totalPrice;
  final double quantity;
  final String additionalNote;

  const PaymentView({
    super.key,
    this.isCuciLipat = false,
    this.isCuciSetrika = false,
    this.totalPrice = 0.0,
    this.quantity = 0.0,
    this.additionalNote = '',
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      init: PaymentController(),
      builder: (_) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 252, 252, 252),
          appBar: AppBar(
            title: const Text('Pembayaran'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      _buildTitleSection(
                        icon: Icons.access_time_rounded,
                        title: 'Waktu Pengambilan',
                      ),
                      const SizedBox(height: 20),
                      _buildTakeUpTimeLaundryPicker(
                        birthDatePickedController:
                            controller.birthDatePickedController,
                        showBirthDateCalendarPicker:
                            controller.showLaundryTakeUpDatePicker,
                      ),
                      const SizedBox(height: 10),
                      _buildTimePicker(
                        timePickedController: controller.timePickedController,
                        showLaundryTakeUpTimePicker:
                            controller.showLaundryTakeUpTimePicker,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  _buildTitleSection(
                    icon: Icons.access_time_rounded,
                    title: 'Alamat',
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: controller.showAddressModal,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.1),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildAddressSummary(), // Show address summary here
                          CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.2),
                            child: const Icon(
                              Icons.chevron_right_rounded,
                              color: Colors.lightBlueAccent,
                              size: 36,
                            ),
                          ),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     _buildAddressSummary(), // Show address summary here
                          //     const SizedBox(height: 16),
                          //     SizedBox(
                          //       width: double.infinity,
                          //       child: TextButton(
                          //         onPressed: () {
                          //           controller.showAddressModal();
                          //         },
                          //         child: const Text('Atur Alamat'),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomBarTotal(
            isLoading: controller.isLoading,
            buttonTitle: 'Laundry Sekarang',
            isInputValid: controller.isInputValid,
            onButtonClicked: () {
              if (controller.isInputValid) {
                controller.saveOrderToFirestore(
                  additionalNote: additionalNote,
                  isCuciLipat: isCuciLipat,
                  isCuciSetrika: isCuciSetrika,
                  quantity: quantity,
                  totalPrice: totalPrice,
                ); // Panggil method untuk menyimpan data
              } else {
                Get.snackbar(
                    'Peringatan', 'Harap lengkapi semua input terlebih dahulu');
              }
            },
            totalPrice: totalPrice,
          ),
        );
      },
    );
  }

  Row _buildTitleSection({
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.lightBlueAccent,
          size: 30,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: semiBoldText18,
        ),
      ],
    );
  }

  Widget _buildTakeUpTimeLaundryPicker({
    required TextEditingController birthDatePickedController,
    required void Function() showBirthDateCalendarPicker,
  }) {
    return InkWell(
      onTap: showBirthDateCalendarPicker,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withOpacity(0.1),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tanggal',
                  style: semiBoldText16,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  birthDatePickedController.text.isEmpty
                      ? 'Pilih Tanggal Pengambilan'
                      : birthDatePickedController.text,
                  style: regularText16,
                ),
              ],
            ),
            CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.2),
              child: const Icon(
                Icons.chevron_right_rounded,
                color: Colors.lightBlueAccent,
                size: 36,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker({
    required TextEditingController timePickedController,
    required void Function() showLaundryTakeUpTimePicker,
  }) {
    return InkWell(
      onTap: showLaundryTakeUpTimePicker,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withOpacity(0.1),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jam',
                  style: semiBoldText16,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  timePickedController.text.isEmpty
                      ? 'Pilih Jam Pengambilan'
                      : timePickedController.text,
                  style: regularText16,
                ),
              ],
            ),
            CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.2),
              child: const Icon(
                Icons.chevron_right_rounded,
                color: Colors.lightBlueAccent,
                size: 36,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressSummary() {
    return GetBuilder<PaymentController>(
      builder: (_) {
        final name = _.nameController.text;
        final phone = _.phoneController.text;
        final address = _.addressController.text;
        final houseNumber = _.houseNumberController.text;

        if (name.isEmpty &&
            phone.isEmpty &&
            address.isEmpty &&
            houseNumber.isEmpty) {
          return Text(
            'Belum ada alamat terisi',
            style: mediumText14,
          );
        } else {
          return SizedBox(
            width: MediaQuery.sizeOf(Get.context!).width / 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name | $phone',
                  style: mediumText14,
                ),
                const SizedBox(height: 5),
                Text(
                  address,
                  overflow: TextOverflow.clip,
                  maxLines: 4,
                ),
                Text('No.$houseNumber'),
              ],
            ),
          );
        }
      },
    );
  }
}
