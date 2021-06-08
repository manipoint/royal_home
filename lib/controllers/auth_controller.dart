import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_home/constants/controllers.dart';
import 'package:royal_home/constants/firebase.dart';
import 'package:royal_home/constants/ic_images.dart';
import 'package:royal_home/models/product.dart';
import 'package:royal_home/models/user.dart';
import 'package:royal_home/screens/auth/auth.dart';
import 'package:royal_home/screens/home/home.dart';
import 'package:royal_home/widgets/loading.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  RxBool isLoggedIn = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  String usersCollection = "users";
  Rx<UserModel> userModel = UserModel().obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => AuthenticationScreen());
    } else {
      userModel.bindStream(listenToUser());
      Get.offAll(() => HomeScreen());
    }
  }

  void signIn() async {
    try {
      Loading();
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _clearControllers();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
    }
  }

  void signUp() async {
    Loading();
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userId = result.user!.uid;
        _addUserToFirestore(_userId);
        _clearControllers();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Signup Failed", "Try again");
    }
  }

  void signOut() async {
    auth.signOut();
  }

  _addUserToFirestore(String userId) {
    firebaseFirestore.collection(usersCollection).doc(userId).set({
      "name": name.text.trim(),
      "id": userId,
      "email": email.text.toLowerCase().trim(),
      "phone": phone.text.trim(),
      "cart": []
    });
  }

  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(firebaseUser.value!.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromSnapshot(snapshot));

  _clearControllers() {
    name.clear();
    email.clear();
    password.clear();
    phone.clear();
  }

  updateUserData(Map<String, dynamic> data) {
    logger.i("UPDATED");
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value!.uid)
        .update(data);
  }

  // double updatecostData(double? price) {
  //   double cost = price! * cartController.cartModel.value.quantity!;
  //   logger.i("UPDATED cost");
  //   firebaseFirestore
  //       .collection(usersCollection)
  //       .doc(firebaseUser.value!.uid)
  //       .collection("cart")
  //       .doc(cartController.cartModel.value.id)
  //       .update({"cost": cost}).then((value) => logger.i(cost));
  //   return cost;
  // }
}
