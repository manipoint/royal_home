class CartModel {
  static const ID = "id";
  static const PRODUCT_ID = "productId";
  static const NAME = "name";
  static const PICTURE = "picture";
  static const QUANTITY = "quantity";
  static const COST = "cost";
  static const PRICE = "price";

  String? id;
  String? productId;
  String? name;
  String? picture;
   int? quantity ;
  double? cost;
  double? price;

  CartModel(
      {this.id,
      this.productId,
      this.name,
      this.picture,
      this.quantity,
      this.cost,
      this.price});
  CartModel.fromMap(Map? data) {
    id = data![ID];
    productId = data[PRODUCT_ID];
    name = data[NAME];
    picture = data[PICTURE];
    quantity = data[QUANTITY].toInt();
    cost = data[COST].toDouble();
    price = data[PRICE].toDouble();
  }

  Map? toJson() => {
        ID: id,
        PRODUCT_ID: productId,
        NAME: name,
        PICTURE: picture,
        QUANTITY: quantity,
        COST: cost ,
        PRICE: price,
      };
}
