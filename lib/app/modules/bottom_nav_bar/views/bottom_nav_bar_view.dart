import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nusa_wash_laundry/app/common/theme/font.dart';
import 'package:nusa_wash_laundry/app/modules/detail_service/views/detail_service_view.dart';
import 'package:nusa_wash_laundry/app/widgets/title_text.dart';
import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BottomNavBarController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() => controller.pages[controller.currentIndex.value]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(
            color: Colors.transparent,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey.withOpacity(0.6),
                            ),
                            child: const Divider(
                              // indent: 150,
                              // endIndent: 150,
                              height: 4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TitleText(
                          title: 'Pilih Opsi Layanan Laundry',
                          textStyle: semiBoldText20,
                        ),
                        const SizedBox(height: 10),

                        InkWell(
                          onTap: () => Get.to(
                            () => DetailServiceView(
                              isCuciLipat: true,
                            ),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              // color: Colors.blue.withOpacity(0.1),
                              border: Border.all(color: Colors.blue),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 16),
                                Image.asset(
                                  'assets/images/ic_cucilipat.png',
                                  height: 70,
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Cuci Lipat',
                                      style: boldText24.copyWith(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Text(
                                      'Harga mulai dari Rp6.000',
                                      style: regularText10.copyWith(
                                        color: Colors.blue.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () => Get.to(
                            () => DetailServiceView(
                              isCuciLipat: true,
                            ),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              // color: Colors.blue.withOpacity(0.1),
                              border: Border.all(color: Colors.blue),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 16),
                                Image.asset(
                                  'assets/images/ic_laundrysatuan.png',
                                  height: 70,
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Laundry Satuan',
                                      style: boldText24.copyWith(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Text(
                                      'Harga mulai dari Rp10.000',
                                      style: regularText10.copyWith(
                                        color: Colors.blue.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () => Get.to(
                            () => DetailServiceView(
                              isCuciSetrika: true,
                            ),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              // color: Colors.blue.withOpacity(0.1),
                              border: Border.all(color: Colors.blue),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 16),
                                Image.asset(
                                  'assets/images/ic_cucisetrika.png',
                                  height: 70,
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Cuci Setrika',
                                      style: boldText24.copyWith(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Text(
                                      'Harga mulai dari Rp7.000',
                                      style: regularText10.copyWith(
                                        color: Colors.blue.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        // CustomTextField(,
                        //   label: 'Add New Task',
                        //   controller: controller.textEditingController,
                        //   hintText: 'New Task',
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     // CustomElevatedButton(
                        //     //   onPressed: () {
                        //     //     controller.handleCreateTodo();
                        //     //     Navigator.pop(context);
                        //     //   },
                        //     //   text: 'Save',
                        //     //   textColor: Colors.black,
                        //     //   backgroundColor: Colors.greenAccent,
                        //     //   borderSide: const BorderSide(
                        //     //     color: Colors.greenAccent,
                        //     //   ),
                        //     //   minWidth: 0,
                        //     //   minHeight: 30,
                        //     // ),
                        //     CustomElevatedButton(
                        //       onPressed: () {},
                        //       text: 'Kembali',
                        //       textStyle: semiBoldText16.copyWith(
                        //         color: kColorScheme.primary,
                        //       ),
                        //       buttonStyle: primary500BorderButton,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.lightBlue,
            unselectedItemColor: Colors.grey.withOpacity(0.8),
            onTap: (index) {
              controller.changePage(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profil'),
            ],
          )),
    );
  }
}
