import 'package:flutter/material.dart';
import 'package:royal_home/constants/controllers.dart';
import 'package:royal_home/screens/payment/widget/payment_widget.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.green.withOpacity(.4),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Payment History",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: paymentController.payments
                .map((e) => PaymentWidget(paymentsModel: e))
                .toList(),
          )
        ],
      ),
    );
  }
}
