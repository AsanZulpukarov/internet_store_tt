class Product {
  int? id;
  late String name;
  late String description;
  late int price;
  late String? urlImage;

  static String productsTable = "Products";
  static String columnId = "id";
  static String columnName = "name";
  static String columnDescription = "description";
  static String columnPrice = "price";
  static String columnUrlImage = "urlImage";

  Product(
      {required this.name,
      required this.description,
      required this.price,
      this.urlImage});

  Product.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    description = map[columnDescription];
    price = map[columnPrice];
    urlImage = map[columnUrlImage];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map[columnId] = id;
    map[columnName] = name;
    map[columnDescription] = description;
    map[columnPrice] = price;
    map[columnUrlImage] = urlImage;
    return map;
  }
}
