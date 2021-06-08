import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:royal_home/models/cart.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const PHONE = "phone";
  static const CART = "cart";

  String? id;
  String? name;
  String? email;
  String? phone;

  List<CartModel>? cart;

  UserModel({this.id, this.name, this.email, this.phone, this.cart});

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    id = snapshot.data()?[ID];
    name = snapshot.data()?[NAME];
    email = snapshot.data()?[EMAIL];
    phone = snapshot.data()?[PHONE];
    cart = _convertCartItems(snapshot.data()![CART] ?? []);
  }

  List<CartModel> _convertCartItems(List cartFomDb) {
    List<CartModel> _result = [];
    if (cartFomDb.length > 0) {
      cartFomDb.forEach((element) {
        _result.add(CartModel.fromMap(element));
      });
    }
    return _result;
  }

  List cartItemsToJson() => cart!.map((item) => item.toJson()).toList();
}
