
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_home/constants/ic_images.dart';
import 'package:royal_home/controllers/app_controller.dart';

import 'widgets/bottom_text.dart';
import 'widgets/login.dart';
import 'widgets/signup.dart';

class AuthenticationScreen extends StatelessWidget {
  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.width / 8),
            Image.asset(RHAppLogo, width: 200,),
            SizedBox(height: MediaQuery.of(context).size.width / 10),

            Visibility(
                visible: _appController.isLoginWidgetDisplayed.value,
                child: LoginWidget()),
            Visibility(
                visible: !_appController.isLoginWidgetDisplayed.value,
                child: RegistrationWidget()),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: _appController.isLoginWidgetDisplayed.value,
              child: BottomTextWidget(
                onTap: () =>
                  _appController.changeDIsplayedAuthWidget
                ,
                text1: "Don\'t have an account?",
                text2: "Create account!",
              ),
           ),
            Visibility(
              visible: !_appController.isLoginWidgetDisplayed.value,
              child: BottomTextWidget(
                onTap: () =>
                  _appController.changeDIsplayedAuthWidget
                ,
                text1: "Already have an account?",
                text2: "Sign in!!",
              ),
            ),
          ],
        ),
      ),)
    );
  }
}