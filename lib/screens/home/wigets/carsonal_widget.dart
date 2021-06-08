import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:royal_home/constants/controllers.dart';
import 'package:royal_home/models/feature.dart';
import 'package:royal_home/screens/home/wigets/carsonal_product.dart';

class ImageSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => CarouselSlider(
          options: CarouselOptions(autoPlay: true, aspectRatio: 1),
          items: productController.fproducts
              .map((FeatureModel featurel) =>
                  CarsonalProductWidget(feature: featurel ))
              .toList(),
        ));
  }
}
