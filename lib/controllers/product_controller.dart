import 'dart:async';
import 'package:get/get.dart';
import 'package:royal_home/constants/firebase.dart';
import 'package:royal_home/models/feature.dart';
import 'package:royal_home/models/product.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  RxList<FeatureModel> fproducts = RxList<FeatureModel>([]);

  String collection = "products";
  @override
  void onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
    fproducts.bindStream(getFeatureProducts());
  }

  Stream<List<ProductModel>> getAllProducts() =>
      firebaseFirestore.collection(collection).snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data())).toList());  

  Stream<List<FeatureModel>> getFeatureProducts() => firebaseFirestore
      .collection(collection)
      .where('feature', isEqualTo: true)
      .snapshots().map((event) => event.docs.map((e) => FeatureModel.fromMap(e.data())).toList());
}
