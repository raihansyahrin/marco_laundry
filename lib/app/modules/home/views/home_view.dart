import 'package:carousel_slider/carousel_slider.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nusa_wash_laundry/app/common/theme/font.dart';
import 'package:nusa_wash_laundry/app/utils/string_utils.dart';
import 'package:nusa_wash_laundry/app/widgets/card_job_vertical.dart';
import 'package:nusa_wash_laundry/app/widgets/horizontal_card_listview.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
        return ColorfulSafeArea(
          color: Colors.lightBlue.withOpacity(0.5),
          child: Scaffold(
            backgroundColor: Colors.lightBlue.withOpacity(0.5),
            body: RefreshIndicator(
              onRefresh: () async {
                await controller.getOrder();
                await controller.getUserData();
              },
              color: Colors.lightBlue,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/LogoNusaWash.png',
                            height: 50,
                          ),
                          controller.isLoadingUser
                              ? Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 148, 148, 148),
                                  highlightColor:
                                      const Color.fromARGB(255, 102, 95, 95),
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.only(
                                    top: 3,
                                    bottom: 3,
                                    left: 12,
                                    right: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 0, 67, 122),
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.lightBlue.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: const Offset(
                                          0,
                                          2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        controller.name!.split(' ').first,
                                        style: mediumText12.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Container(
                                          height: 30,
                                          width: 30,

                                          color: Colors
                                              .white, // Warna putih untuk bagian yang tidak diisi gambar
                                          child: controller.profileImageUrl !=
                                                  null
                                              ? Image.network(
                                                  controller.profileImageUrl!,
                                                  height: 24,
                                                  width: 24,
                                                  fit: BoxFit
                                                      .cover, // Penting untuk memastikan gambar terisi penuh
                                                )
                                              : const Icon(
                                                  Icons.person,
                                                  size: 24,
                                                  color: Colors
                                                      .grey, // Warna ikon jika tidak ada gambar
                                                ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    controller.order == null
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 210,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 80,
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 0, 67, 122),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 16,
                                      ),
                                      child: Text(
                                        'Status laundry,',
                                        style: semiBoldText14.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 40,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlue,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: 0,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20),
                                              ),
                                              child: SvgPicture.asset(
                                                'assets/images/img_backgroundcard.svg',
                                                // alignment: Alignment.center,
                                                // width: 200,
                                                height: 82.5,
                                                fit: BoxFit.fill,
                                                color: Colors.blue
                                                    .withOpacity(0.4),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/ic_laundrysatuan.png',
                                                fit: BoxFit.fitWidth,
                                                width: 80,
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Belum ada pesanan',
                                                      style: semiBoldText18
                                                          .copyWith(
                                                        color: Colors.white,
                                                      ),
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      'Ayo laundry di NusaWash',
                                                      style: regularText12
                                                          .copyWith(
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : controller.isLoading
                            ? Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 148, 148, 148),
                                highlightColor:
                                    const Color.fromARGB(255, 102, 95, 95),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              )
                            : Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                height: 210,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: 80,
                                        alignment: Alignment.topLeft,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 0, 67, 122),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                            left: 16,
                                          ),
                                          child: Text(
                                            'Status laundry kak ${controller.order!.name},',
                                            style: semiBoldText14.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 40,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/ic_laundrysatuan.png',
                                                fit: BoxFit.fitWidth,
                                                width: 80,
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Sedang dilaundry',
                                                      style: semiBoldText18
                                                          .copyWith(
                                                        color: Colors.white,
                                                      ),
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                    Text(
                                                      'Mohon ditunggu ya kak.',
                                                      style: regularText12
                                                          .copyWith(
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Container(
                                                      height: 1,
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width -
                                                          115,
                                                      margin:
                                                          const EdgeInsetsDirectional
                                                              .only(
                                                        start: 1.0,
                                                        // end: 1.0,
                                                      ),
                                                      color: Colors.white
                                                          .withOpacity(0.7),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 5,
                                                          horizontal: 16,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          // color: const Color
                                                          //     .fromARGB(
                                                          //     255, 0, 67, 122),
                                                          color: Colors.amber,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            100,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          // formatCurrency(
                                                          //   controller.order!
                                                          //       .totalPrice,
                                                          // ),
                                                          'On Progress',
                                                          style: mediumText14
                                                              .copyWith(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 248, 253, 255),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kenapa Laundry di Nusa Wash?',
                                  style: semiBoldText16.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const HorizontalCardListView(),
                                const SizedBox(height: 20),
                                Text(
                                  'Alamat Laundry',
                                  style: semiBoldText16.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.1),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.sizeOf(Get.context!).width,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.location_pin,
                                          color: Colors.lightBlue,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Nusa Wash Laundry',
                                                style: semiBoldText14,
                                                overflow: TextOverflow.clip,
                                                maxLines: 2,
                                              ),
                                              Text(
                                                '+62 851 7408 5121',
                                                style: mediumText14,
                                                overflow: TextOverflow.clip,
                                                maxLines: 2,
                                              ),
                                              const SizedBox(height: 5),
                                              const Text(
                                                'Perumahan Griya Alifa, JI.Sukabirus, Kabupaten Bandung, Jawa Barat',
                                                overflow: TextOverflow.clip,
                                                maxLines: 4,
                                              ),

                                              // const Text('No.asdfa'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildImageBannerCarousel(
                                  current: controller.current,
                                  imageList: controller.listImage,
                                  onPageChanged:
                                      controller.onPageChangedCarousel,
                                ),
                              ],
                            ),
                          ),

                          // Positioned(
                          //   top: 0,
                          //   child: Container(
                          //     height: 300,
                          //     width:
                          //         MediaQuery.of(context).size.width, // Use full width
                          //     decoration: const BoxDecoration(
                          //       color: Colors.red,
                          //       borderRadius: BorderRadius.vertical(
                          //         top: Radius.circular(20),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageBannerCarousel({
    required int current,
    required List<String> imageList,
    required void Function(int index, CarouselPageChangedReason reason)
        onPageChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nusa Wash Laundry',
          style: semiBoldText16.copyWith(
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            _buildImageSlider(
              current: current,
              imageList: imageList,
              onPageChanged: onPageChanged,
            ),
            _buildDotSlider(
              current: current,
              imageList: imageList,
            ),
          ],
        ),
      ],
    );
  }

  _buildImageSlider({
    required int current,
    required List<String> imageList,
    required void Function(int index, CarouselPageChangedReason reason)
        onPageChanged,
  }) {
    return CarouselSlider(
      options: CarouselOptions(
        clipBehavior: Clip.none,
        height: MediaQuery.of(Get.context!).size.width * 9 / 16,
        viewportFraction: 0.98,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        onPageChanged: onPageChanged,
      ),
      items: imageList.map(
        (i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(i),
                  ),
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }

  _buildDotSlider({
    required int current,
    required List<String> imageList,
  }) {
    return Positioned(
      bottom: 8.0,
      right: 16.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: imageList.map((url) {
          int index = imageList.indexOf(url);
          return Row(children: [
            index == current ? _buildDotWithProgress() : _buildDot(),
            if (index < imageList.length - 1) const SizedBox(width: 4),
          ]);
        }).toList(),
      ),
    );
  }

  _buildDotWithProgress() {
    return SizedBox(
      width: 24.0,
      height: 8.0,
      child: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: TweenAnimationBuilder<double?>(
          duration: const Duration(seconds: 5),
          tween: Tween<double?>(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return LinearProgressIndicator(
              minHeight: 8.0,
              backgroundColor: Colors.white.withOpacity(0.8),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
              value: value ?? 0.0,
              borderRadius: BorderRadius.circular(10),
            );
          },
        ),
      ),
    );
  }

  _buildDot() {
    return Container(
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white.withOpacity(0.8),
      ),
    );
  }
}
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:colorful_safe_area/colorful_safe_area.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nusa_wash_laundry/app/data/model/order.dart';
// import 'package:nusa_wash_laundry/app/modules/home/controllers/home_controller.dart';
// import 'package:shimmer/shimmer.dart';

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeController>(
//       init: HomeController(),
//       builder: (controller) {
//         return StreamBuilder<Map<String, dynamic>>(
//           stream: controller.userDataStream.stream,
//           builder: (context, snapshotUserData) {
//             return StreamBuilder<OrderLaundry?>(
//               stream: controller.orderStream.stream,
//               builder: (context, snapshotOrder) {
//                 return ColorfulSafeArea(
//                   color: Colors.lightBlue.withOpacity(0.5),
//                   child: Scaffold(
//                     backgroundColor: Colors.lightBlue.withOpacity(0.5),
//                     body: RefreshIndicator(
//                       onRefresh: () async {
//                         await controller.getOrder();
//                         await controller.getUserData();
//                       },
//                       color: Colors.lightBlue,
//                       child: SingleChildScrollView(
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         keyboardDismissBehavior:
//                             ScrollViewKeyboardDismissBehavior.onDrag,
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 6,
//                                 horizontal: 20,
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Image.asset(
//                                     'assets/images/LogoNusaWash.png',
//                                     height: 50,
//                                   ),
//                                   snapshotUserData.hasData
//                                       ? Container(
//                                           padding: const EdgeInsets.only(
//                                             top: 3,
//                                             bottom: 3,
//                                             left: 12,
//                                             right: 4,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: const Color.fromARGB(
//                                                 255, 0, 67, 122),
//                                             borderRadius:
//                                                 BorderRadius.circular(100),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.lightBlue
//                                                     .withOpacity(0.5),
//                                                 spreadRadius: 1,
//                                                 blurRadius: 5,
//                                                 offset: const Offset(
//                                                   0,
//                                                   2,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 snapshotUserData.data!['name']
//                                                     .split(' ')
//                                                     .first,
//                                                 style: const TextStyle(
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                               const SizedBox(width: 10),
//                                               ClipRRect(
//                                                 borderRadius:
//                                                     BorderRadius.circular(100),
//                                                 child: Container(
//                                                   height: 30,
//                                                   width: 30,
//                                                   color: Colors.white,
//                                                   child: snapshotUserData.data![
//                                                               'profileImageUrl'] !=
//                                                           null
//                                                       ? Image.network(
//                                                           snapshotUserData
//                                                                   .data![
//                                                               'profileImageUrl'],
//                                                           height: 24,
//                                                           width: 24,
//                                                           fit: BoxFit.cover,
//                                                         )
//                                                       : const Icon(
//                                                           Icons.person,
//                                                           size: 24,
//                                                           color: Colors.grey,
//                                                         ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         )
//                                       : const SizedBox(),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             snapshotOrder.data == null
//                                 ? _buildNoOrderWidget()
//                                 : controller.isLoading
//                                     ? _buildLoadingWidget()
//                                     : _buildOrderWidget(controller.order!),
//                             const SizedBox(height: 20),
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height,
//                               width: double.infinity,
//                               child: Stack(
//                                 children: [
//                                   Positioned(
//                                     bottom: 0,
//                                     child: Container(
//                                       height:
//                                           MediaQuery.of(context).size.height,
//                                       width: MediaQuery.of(context).size.width,
//                                       decoration: const BoxDecoration(
//                                         color:
//                                             Color.fromARGB(255, 248, 253, 255),
//                                         borderRadius: BorderRadius.vertical(
//                                           top: Radius.circular(20),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(20.0),
//                                     child: _buildImageBannerCarousel(
//                                       current: controller.current,
//                                       imageList: controller.listImage,
//                                       onPageChanged:
//                                           controller.onPageChangedCarousel,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildNoOrderWidget() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       height: 210,
//       child: Stack(
//         children: [
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: 80,
//               alignment: Alignment.topLeft,
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 0, 67, 122),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.only(
//                   top: 10,
//                   left: 16,
//                 ),
//                 child: Text(
//                   'Status laundry kak Belum ada pesanan,',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 40,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: 150,
//               decoration: BoxDecoration(
//                 color: Colors.lightBlue,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'assets/images/ic_laundrysatuan.png',
//                       fit: BoxFit.fitWidth,
//                       width: 80,
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             'Belum ada pesanan',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                             overflow: TextOverflow.clip,
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             'Ayo laundry di NusaWash',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.white.withOpacity(0.8),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLoadingWidget() {
//     return Shimmer.fromColors(
//       baseColor: const Color.fromARGB(255, 148, 148, 148),
//       highlightColor: const Color.fromARGB(255, 102, 95, 95),
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 20),
//         height: 200,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.grey.withOpacity(0.5),
//           borderRadius: BorderRadius.circular(20),
//         ),
//       ),
//     );
//   }

//   Widget _buildOrderWidget(OrderLaundry order) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       height: 210,
//       child: Stack(
//         children: [
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: 80,
//               alignment: Alignment.topLeft,
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 0, 67, 122),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   top: 10,
//                   left: 16,
//                 ),
//                 child: Text(
//                   'Status laundry kak ${order.name},',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 40,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: 150,
//               decoration: BoxDecoration(
//                 color: Colors.lightBlue,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'assets/images/ic_laundrysatuan.png',
//                       fit: BoxFit.fitWidth,
//                       width: 80,
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             'Sedang dilaundry',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                             overflow: TextOverflow.clip,
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             'Mohon ditunggu ya kak.',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.white.withOpacity(0.8),
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           Container(
//                             height: 1,
//                             width: MediaQuery.of(Get.context!).size.width - 115,
//                             margin: const EdgeInsetsDirectional.only(
//                               start: 1.0,
//                             ),
//                             color: Colors.white.withOpacity(0.7),
//                           ),
//                           const SizedBox(height: 10),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 5,
//                                 horizontal: 16,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.amber,
//                                 borderRadius: BorderRadius.circular(100),
//                               ),
//                               child: const Text(
//                                 'On Progress',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildImageBannerCarousel({
//     required int current,
//     required List<String> imageList,
//     required void Function(int index, CarouselPageChangedReason reason)
//         onPageChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Nusa Wash Laundry',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Colors.lightBlue,
//           ),
//         ),
//         Stack(
//           children: [
//             _buildImageSlider(
//               current: current,
//               imageList: imageList,
//               onPageChanged: onPageChanged,
//             ),
//             _buildDotSlider(
//               current: current,
//               imageList: imageList,
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildImageSlider({
//     required int current,
//     required List<String> imageList,
//     required void Function(int index, CarouselPageChangedReason reason)
//         onPageChanged,
//   }) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         clipBehavior: Clip.none,
//         height: MediaQuery.of(Get.context!).size.width * 9 / 16,
//         viewportFraction: 0.98,
//         autoPlay: true,
//         autoPlayInterval: const Duration(seconds: 5),
//         onPageChanged: onPageChanged,
//       ),
//       items: imageList.map(
//         (i) {
//           return Builder(
//             builder: (BuildContext context) {
//               return Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage(i),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ).toList(),
//     );
//   }

//   Widget _buildDotSlider({
//     required int current,
//     required List<String> imageList,
//   }) {
//     return Positioned(
//       bottom: 8.0,
//       right: 16.0,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: imageList.map((url) {
//           int index = imageList.indexOf(url);
//           return Row(children: [
//             index == current ? _buildDotWithProgress() : _buildDot(),
//             if (index < imageList.length - 1) const SizedBox(width: 4),
//           ]);
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildDotWithProgress() {
//     return SizedBox(
//       width: 24.0,
//       height: 8.0,
//       child: AnimatedSwitcher(
//         duration: const Duration(seconds: 1),
//         child: TweenAnimationBuilder<double>(
//           duration: const Duration(seconds: 5),
//           tween: Tween<double>(begin: 0.0, end: 1.0),
//           builder: (context, value, child) {
//             return LinearProgressIndicator(
//               minHeight: 8.0,
//               backgroundColor: Colors.white.withOpacity(0.8),
//               valueColor: const AlwaysStoppedAnimation<Color>(
//                 Colors.white,
//               ),
//               value: value ?? 0.0,
//               borderRadius: BorderRadius.circular(10),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildDot() {
//     return Container(
//       width: 8.0,
//       height: 8.0,
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//         color: Colors.white.withOpacity(0.8),
//       ),
//     );
//   }
// }
