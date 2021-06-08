class FeatureModel {
  static const ID = "id";
  static const NAME = "name";
  static const PICTURE = "picture";
  static const DESCRIPTION = "description";
  static const DATE = "date";
  static const PRICE = "price";
 
  static const FEATURE = "feature";


  String? id;
  String? name;
  String? picture;
  String? description;
  DateTime? date;
  double? price;
  bool? feature;


  FeatureModel(
      {this.id,
      this.name,
      this.picture,
      this.description,
      this.date,
      this.price,
      this.feature,
      });

  FeatureModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    name = data[NAME];
    picture = data[PICTURE];
    description = data[DESCRIPTION];
    date = data[DATE].toDate();
    price = data[PRICE].toDouble();
   feature = data[FEATURE];
   
  }
}
