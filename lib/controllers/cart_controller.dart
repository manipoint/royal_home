import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_home/constants/controllers.dart';
import 'package:royal_home/constants/ic_images.dart';
import 'package:royal_home/models/cart.dart';
import 'package:royal_home/models/product.dart';
import 'package:royal_home/models/user.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();

  Rx<CartModel> cartModel = CartModel().obs;
  Rx<double> totalCartPrice = 0.0.obs;
  int quantaty = 1;
  Rx<int> changeQuntaty = 1.obs;

  @override
  void onReady() {
    super.onReady();
    ever(authController.userModel, changeCartTotalPrice);
    ever(cartController.cartModel, decreaseQuantity);
    ever(cartController.cartModel, increaseQuantity);
  }

  double? getCost(CartModel item) {
    double cost = 1;
    cost = item.cost! * item.quantity!;
    return cost;
  }

  void addProductToCart(ProductModel product) {
    try {
      if (_isItemAlreadyAdded(product)) {
        Get.snackbar("Check your cart", "${product.name} is already added");
      } else {
        String itemId = Uuid().v1();
        authController.updateUserData({
          "cart": FieldValue.arrayUnion([
            {
              "id": itemId,
              "productId": product.id,
              "name": product.name,
              "quantity": 1,
              "price": product.price,
              "picture": product.picture,
              "cost": product.price! 
            }
          ])
        });
        Get.snackbar("Item added", "${product.name} was added to your cart");
      }
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }

  void removeCartItem(CartModel cartItem) {
    try {
      authController.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      });
    } catch (e) {
      Get.snackbar("Error", "Cannot remove this item");
      debugPrint(e.toString());
    }
  }

  changeCartTotalPrice(UserModel userModel) {
    totalCartPrice.value = 0.0;
    if (userModel.cart!.isNotEmpty) {
      authController.userModel.value.cart!.forEach((cartItem) {
        int? cartq = cartItem.quantity ?? 1 ;
        totalCartPrice += cartItem.cost! * cartq;
      });
    }
  }

  bool _isItemAlreadyAdded(ProductModel product) =>
      authController.userModel.value.cart!
          .where((item) => item.productId == product.id)
          .isNotEmpty;

  void decreaseQuantity(CartModel item) {
    if (item.quantity == 1) {
      removeCartItem(item);
    } else {
      removeCartItem(item);
      // print("before decrese ${item.quantity}");
      quantaty = item.quantity!;
      quantaty--;
      item.quantity = quantaty;

      // print("After decrese ${item.quantity!}");
      authController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
      
    }
  }

  void increaseQuantity(CartModel item) {
    removeCartItem(item);
    // print("before increse ${item.quantity}");
    quantaty = item.quantity!;
    quantaty++;
    item.quantity = quantaty;
    // print("After increase ${item.quantity!}");
    // logger.i({"quantity": item.quantity});
    authController.updateUserData({
      "cart": FieldValue.arrayUnion([item.toJson()])
    });
    
  }
}
