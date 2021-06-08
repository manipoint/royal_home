import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:royal_home/constants/controllers.dart';
import 'package:royal_home/constants/firebase.dart';
import 'package:royal_home/constants/ic_images.dart';
import 'package:royal_home/models/payment.dart';
import 'package:royal_home/screens/payment/payment_screen.dart';
import 'package:royal_home/utils/config.dart';
import 'package:royal_home/widgets/showLoading.dart';
import 'package:uuid/uuid.dart';
import 'package:royal_home/.env';
//import 'package:http/http.dart' as http;

class PaymentsController extends GetxController {
  static PaymentsController instance = Get.find();
  String collection = "payments";
  List<PaymentsModel> payments = [];
  Map<String, dynamic>? _paymentSheetData;
  Rx<double> totalCost = 0.0.obs;
  // @override
  // void onInit() {
  //   super.onInit();

  //}

  @override
  void onReady() {
    super.onReady();
    Stripe.publishableKey = stripePublishableKey;
    Stripe.merchantIdentifier = 'MerchantIdentifier';
  }

  createPaymentMethod() {
    _initPaymentSheet();
    if (_paymentSheetData != null) {
      _displayPaymentSheet();
    }

    //Stripe.instance.isApplePaySupported.value ? handlePayPress() : () {};
  }

  Future<void> _initPaymentSheet() async {
    try {
      // 1. create payment intent on the server
      _paymentSheetData = await _createTestPaymentSheet();

      print("paymentsheet data is ${_paymentSheetData!['paymentIntent']}");

      if (_paymentSheetData!['error'] != null) {
        Get.snackbar('ErrorCode', '${_paymentSheetData!['error']}');
        return;
      }
      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        applePay: true,
        googlePay: true,
        style: ThemeMode.dark,
        testEnv: true,
        merchantCountryCode: 'DE',
        merchantDisplayName: "Royal Home Payments",
        customerId: _paymentSheetData!['customer'],
        paymentIntentClientSecret: _paymentSheetData!['paymentIntent'],
        customerEphemeralKeySecret: _paymentSheetData!['ephemeralKey'],
      ));
       _displayPaymentSheet();
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  Future<void> _displayPaymentSheet() async {
    String custumerId = _paymentSheetData!['customer'];
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
              clientSecret: _paymentSheetData!['paymentIntent'],
              confirmPayment: true));
      _paymentSheetData = null;

      Get.snackbar('Royle Home', 'Payment succesfully completed');
      _addToCollection(paymentId: custumerId, paymentStatus: 'success');
      authController.updateUserData({"cart": []});
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<Map<String, dynamic>> _createTestPaymentSheet() async {
    double totalCosttodouble = totalCost.toDouble();
    totalCosttodouble = (cartController.totalCartPrice.value / 156);
    int amount = (totalCosttodouble * 100).toInt();
    final url = Uri.parse('$kApiUrl/payment-sheet');
    final responce = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': authController.userModel.value.email,
        'currency': 'usd',
        'amount': amount,
        'items': [
          {'id': 'id'}
        ],
        'request_three_d_secure': 'any',
      }),
    );
    return json.decode(responce.body);
  }

  _addToCollection({String? paymentStatus, String? paymentId}) {
    String id = Uuid().v1();
    firebaseFirestore.collection(collection).doc(id).set({
      "id": id,
      "clientId": authController.userModel.value.id,
      "status": paymentStatus,
      "paymentId": paymentId,
      "cart": authController.userModel.value.cartItemsToJson(),
      "amount": cartController.totalCartPrice.value.toStringAsFixed(2),
      "createdAt": DateTime.now().microsecondsSinceEpoch,
    });
  }

  getPaymentHistory() {
    showLoading();
    payments.clear();
    firebaseFirestore
        .collection(collection)
        .where("clientId", isEqualTo: authController.userModel.value.id)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        PaymentsModel payment = PaymentsModel.fromMap(doc.data());
        payments.add(payment);
      });

      logger.i("length ${payments.length}");
      dismissLoadingWidget();
      Get.to(() => PaymentScreen());
    });
  }

}
