// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:nusa_wash_laundry/app/modules/bottom_nav_bar/views/bottom_nav_bar_view.dart';
// import 'package:nusa_wash_laundry/app/modules/home/controllers/home_controller.dart';
// import 'package:nusa_wash_laundry/app/modules/login/views/login_view.dart';
// import 'package:nusa_wash_laundry/app/modules/profile/controllers/profile_controller.dart';
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   await initializeDateFormatting('id_ID', null);
//   Get.put(HomeController());

//   runApp(
//     GetMaterialApp(
//       title: "Application",
//       initialRoute: FirebaseAuth.instance.currentUser != null
//           ? '/bottom-nav-bar'
//           : '/login',
//       getPages: [
//         GetPage(name: '/login', page: () => const LoginView()),
//         GetPage(
//           name: '/bottom-nav-bar',
//           page: () => const BottomNavBarView(),
//         ), // Ganti dengan halaman bottom nav bar Anda
//       ],
//       theme: ThemeData(
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       debugShowCheckedModeBanner: false,
//       localizationsDelegates: const [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: const [
//         Locale('id', 'ID'),
//       ],
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nusa_wash_laundry/app/modules/bottom_nav_bar/views/bottom_nav_bar_view.dart';
import 'package:nusa_wash_laundry/app/modules/login/views/login_view.dart';
import 'package:nusa_wash_laundry/app/modules/splash_screen/views/splash_screen_view.dart';
import 'package:nusa_wash_laundry/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('id_ID', null);

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreenView()),
        GetPage(name: '/login', page: () => const LoginView()),
        GetPage(name: '/bottom-nav-bar', page: () => const BottomNavBarView()),
      ],
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id', 'ID'),
      ],
    ),
  );
}
