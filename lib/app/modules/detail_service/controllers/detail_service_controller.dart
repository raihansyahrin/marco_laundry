import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nusa_wash_laundry/app/data/model/nusawashservice_model.dart';

class DetailServiceController extends GetxController {
  var selectedServiceIndex = 0.obs;
  var quantity = 0.0.obs;
  var isValidQuantity = true.obs;
  TextEditingController additionalNoteController = TextEditingController();

  final List<Color> itemColorsListCuciLipat = List<Color>.generate(
    listCuciLipat.length,
    (index) => Colors.lightBlue.withOpacity(0.5),
  ).obs;

  void changeColorCuciLipat(int index) {
    selectedServiceIndex.value = index;
    for (int i = 0; i < itemColorsListCuciLipat.length; i++) {
      itemColorsListCuciLipat[i] =
          i == index ? Colors.blue : Colors.lightBlue.withOpacity(0.5);
    }
  }

  final List<Color> itemColorsListCuciSetrika = List<Color>.generate(
    listCuciLipat.length,
    (index) => Colors.lightBlue.withOpacity(0.5),
  ).obs;

  void changeColorCuciSetrika(int index) {
    selectedServiceIndex.value = index;
    for (int i = 0; i < itemColorsListCuciSetrika.length; i++) {
      itemColorsListCuciSetrika[i] =
          i == index ? Colors.blue : Colors.lightBlue.withOpacity(0.5);
    }
  }

  void updateQuantity(String input) {
    // Menghapus angka 0 di depan input jika ada
    String cleanedInput = input.replaceAll(RegExp(r'^0+(?!$)'), '');

    // Cek apakah input setelah dibersihkan sama dengan input awal (yang berarti dimulai dengan 0)
    if (input.startsWith('0') && !input.startsWith('0.')) {
      isValidQuantity.value = false;
      return; // Keluar dari metode jika input dimulai dengan 0 (tanpa desimal)
    }

    // Cek apakah input setelah dibersihkan sama dengan input awal (yang berarti dimulai dengan 0.)
    if (input.startsWith('0.') && !cleanedInput.startsWith('0.')) {
      isValidQuantity.value = false;
      return; // Keluar dari metode jika input dimulai dengan 0.
    }
    if (input.trim().isEmpty) {
      isValidQuantity.value = false;
      return; // Keluar dari metode jika input kosong
    }

    double qty = double.tryParse(cleanedInput.replaceAll(',', '.')) ?? 0.0;
    if (qty < 3) {
      isValidQuantity.value = false;
    } else {
      isValidQuantity.value = true;
      quantity.value = qty;
    }
  }

  double get totalPriceListCuciLipat {
    if (quantity.value >= 3) {
      return listCuciLipat[selectedServiceIndex.value].price * quantity.value;
    } else {
      return 0.0;
    }
  }

  double get totalPriceListCuciSetrika {
    if (quantity.value >= 3) {
      return listCuciSetrika[selectedServiceIndex.value].price * quantity.value;
    } else {
      return 0.0;
    }
  }

  bool get isInputValid {
    return totalPriceListCuciLipat != 0.0 && isValidQuantity.value;
  }

  String getTimeLabel(int index) {
    List<NuswaWashService> services = [...listCuciLipat, ...listCuciSetrika];
    int hours = services[index].time!;

    if (hours < 24) {
      return '$hours jam';
    } else {
      int days = (hours / 24).ceil();
      return '$days hari';
    }
  }
}
