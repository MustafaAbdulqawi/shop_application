class ChangeFavoritesModel {
  bool status;
  String message;
  Data data;

  ChangeFavoritesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ChangeFavoritesModel.fromJson(Map<String, dynamic> json) =>
      ChangeFavoritesModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  dynamic id;
  Product product;

  Data({
    required this.id,
    required this.product,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        product: Product.fromJson(json["product"]),
      );
}

class Product {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        price: json["price"],
        oldPrice: json["old_price"],
        discount: json["discount"],
        image: json["image"],
      );
}
