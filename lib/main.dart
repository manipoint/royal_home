import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_home/controllers/app_controller.dart';
import 'package:royal_home/controllers/cart_controller.dart';
import 'package:royal_home/controllers/payment_controller.dart';
import 'package:royal_home/controllers/product_controller.dart';

import 'constants/firebase.dart';
import 'controllers/auth_controller.dart';
import 'screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   
  await initialization.then((value) {
    Get.put(AppController());
    Get.put(AuthController());
    Get.put(CartController());
    Get.put(ProductController());
    Get.put(PaymentsController());
  });
 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Royal Home',
      theme: ThemeData(
          accentColor: Color.fromARGB(250, 200, 210, 120),
          // primaryColor: Color.fromARGB(250, 60, 250, 0),
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
          backgroundColor: Color.fromARGB(240, 230, 230, 250),
          textTheme:
              GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: SplashScreen(),
    );
  }
}
