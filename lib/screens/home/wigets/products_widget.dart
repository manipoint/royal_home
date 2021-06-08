import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:royal_home/constants/controllers.dart';
import 'package:royal_home/models/product.dart';
import 'package:royal_home/screens/home/wigets/single_product.dart';

class ProductsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.count(crossAxisCount: 2,
    childAspectRatio: .65,
    shrinkWrap: true,
    padding: const EdgeInsets.only(top: 20,bottom: 20),
    mainAxisSpacing: 20.0,
    crossAxisSpacing: 20,
    children: productController.products.map((ProductModel product) {
      return SingleProductWidget(product: product);}).toList()));
  }
}
