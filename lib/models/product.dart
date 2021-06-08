class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const PICTURE = "picture";
  static const DESCRIPTION = "description";
  static const REVIEW = "review";
  static const DATE = "date";
  static const PRICE = "price";
  static const RATING = "rating";
  static const FEATURE = "feature";
  static const SALE = "sale";

  String? id;
  String? name;
  String? picture;
  String? description;
  String? review;
  DateTime? date;
  double? price;
  double? rating;
  bool? feature;
  bool? sale;

  ProductModel(
      {this.id,
      this.name,
      this.picture,
      this.description,
      this.review,
      this.date,
      this.price,
      this.rating,
      this.feature,
      this.sale});

  ProductModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    name = data[NAME];
    picture = data[PICTURE];
    description = data[DESCRIPTION];
    review = data[REVIEW];
    date = data[DATE].toDate();
    price = data[PRICE].toDouble();
    rating = data[RATING].toDouble();
    feature = data[FEATURE];
    sale = data[SALE];
  }
}
