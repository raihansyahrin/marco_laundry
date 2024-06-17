import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nusa_wash_laundry/app/common/styles/colors.dart';
import 'package:nusa_wash_laundry/app/common/theme/font.dart';
import 'package:nusa_wash_laundry/app/data/model/nusawashservice_model.dart';
import 'package:nusa_wash_laundry/app/modules/payment/views/payment_view.dart';
import 'package:nusa_wash_laundry/app/utils/string_utils.dart';
import 'package:nusa_wash_laundry/app/widgets/button_bar_total.dart';
import 'package:nusa_wash_laundry/app/widgets/title_text.dart';
import '../controllers/detail_service_controller.dart';

class DetailServiceView extends GetView<DetailServiceController> {
  bool isCuciLipat;
  bool isCuciSetrika;
  DetailServiceView({
    super.key,
    this.isCuciLipat = false,
    this.isCuciSetrika = false,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 5;
    final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          isCuciLipat ? 'Cuci Lipat' : 'Cuci Setrika',
        ),
        centerTitle: true,
      ),
      body: GetBuilder<DetailServiceController>(
        init: DetailServiceController(),
        builder: (controller) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const TitleText(title: 'Pilih Salah Satu'),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: isCuciLipat,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (itemWidth / itemHeight),
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: listCuciLipat.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => controller.changeColorCuciLipat(index),
                            child: Obx(() {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.lightBlue.withOpacity(0.5),
                                  ),
                                  color:
                                      controller.itemColorsListCuciLipat[index],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        listCuciLipat[index].title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        controller.getTimeLabel(index),
                                      ),
                                      const Divider(),
                                      Text(
                                        '${formatCurrency(listCuciLipat[index].price)}/kg',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible: isCuciSetrika,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          // childAspectRatio: 1.8,
                          childAspectRatio: (itemWidth / itemHeight),
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: listCuciSetrika.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () =>
                                controller.changeColorCuciSetrika(index),
                            child: Obx(() {
                              return Container(
                                decoration: BoxDecoration(
                                  color: controller
                                      .itemColorsListCuciSetrika[index],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        listCuciSetrika[index].title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        controller.getTimeLabel(index),
                                      ),
                                      const Divider(),
                                      Text(
                                        '${formatCurrency(listCuciSetrika[index].price)}/kg',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const TitleText(title: 'Masukkan Banyaknya Laundry'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Obx(() {
                            return TextFormField(
                              // focusNode:
                              //     FocusScope.of(context).requestFocus(FocusNode()),

                              decoration: InputDecoration(
                                // hintText: 'input',
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.all(12.0),
                                fillColor: Colors.white,
                                filled: true,
                                errorText: controller.isValidQuantity.value
                                    ? null
                                    : 'Minimal 3 kg',
                              ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              inputFormatters: Platform.isAndroid
                                  ? [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^(\d+)?\.?\d{0,2}')),
                                    ]
                                  : [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^(\d+)?,?\d{0,2}')),
                                    ],
                              onChanged: (value) =>
                                  controller.updateQuantity(value),
                            );
                          }),
                        ),
                        const SizedBox(width: 10),
                        const Text('kg'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const TitleText(title: 'Catatan Tambahan (Opsional)'),
                    const SizedBox(height: 10),
                    Container(
                      height: 100,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1, color: AppColors.neutralColors[1]),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: TextField(
                        controller: controller.additionalNoteController,
                        style: mediumText12.copyWith(
                            color: AppColors.neutralColors[1]),
                        textAlign: TextAlign.center,
                        maxLines: null,
                        expands: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          hintText: "Berikan catatan tambahan jika perlu...",
                          alignLabelWithHint: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Obx(() {
        return BottomBarTotal(
          buttonTitle: 'Lanjut Pembayaran',
          totalPrice: isCuciLipat
              ? controller.totalPriceListCuciLipat
              : controller.totalPriceListCuciSetrika,
          isInputValid: controller.isInputValid,
          onButtonClicked: () {
            navigateToPaymentView(
              isCuciLipat
                  ? controller.totalPriceListCuciLipat
                  : controller.totalPriceListCuciSetrika,
            );
          },
        );
      }),
    );
  }

  void navigateToPaymentView(double totalPrice) {
    Get.to(
      () => PaymentView(
        isCuciLipat: isCuciLipat,
        isCuciSetrika: isCuciSetrika,
        totalPrice: totalPrice,
        quantity: controller.quantity.value,
        additionalNote: controller.additionalNoteController.text,
      ),
    );
  }
}
