import 'package:flutter/material.dart';
import 'package:royal_home/constants/ic_images.dart';
import 'package:royal_home/widgets/loading.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(RHAppLogo, width: 120,),
          SizedBox(height: 10,),
          Loading()
        ],
      ),
    );
  }
}