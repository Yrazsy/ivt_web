class ProductsObject {
  final List<String> productsList;
  final String pattern;

  ProductsObject(
      this.pattern,
      this.productsList,
      );

  List<String> get getProductsList => productsList;

  String get getPattern => pattern;

  Map<String, dynamic> toJson() => {
    'pattern': pattern,
    'productsList': productsList,
  };

  factory ProductsObject.fromJson(Map<String, dynamic> json) {
    return ProductsObject(
      json['pattern'],
      List<String>.from(json['productsList']),
    );
  }
}