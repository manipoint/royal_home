import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_home/constants/controllers.dart';
import 'package:royal_home/screens/home/wigets/cart_item.dart';
import 'package:royal_home/widgets/custom_text.dart';

class ShoppingCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: CustomText(
                text: "Shopping Cart",
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Obx(() => Column(
                  children: authController.userModel.value.cart!
                  .map((e){
                    return CartItemWidget(cartItem: e,);
                  }).toList()
                      
                )),
          ],
        ),
        Positioned(
            bottom: 30,
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8),
                child: Obx(() => GestureDetector(
                      onTap: () {
                        paymentController.createPaymentMethod();
                      },
                      child: PhysicalModel(
                        color: Colors.grey.withOpacity(.4),
                        elevation: 2,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black,
                            ),
                            child: Container(
                              margin: EdgeInsets.all(14),
                              alignment: Alignment.center,
                              child: CustomText(
                                text:
                                    'Pay Rs ${cartController.totalCartPrice.value.toStringAsFixed(2)}',
                                color: Colors.white,
                                size: 22,
                                weight: FontWeight.normal,
                              ),
                            )),
                      ),
                    ))))
      ],
    );
  }
}

    //TextButton(
                //         onPressed: () {
                //           paymentController.createPaymentMethod();
                //         },
                //         child: Text(
                //           "Pay (Rs ${cartController.totalCartPrice.value.toStringAsFixed(2)})",
                //            style: TextStyle(fontSize:  16, color:  Colors.black, fontWeight: FontWeight.normal),
                //             ))
                  