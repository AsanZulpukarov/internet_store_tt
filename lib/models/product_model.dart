class Product {
  String name;
  String description;
  int price;
  String? urlImage;

  Product(
      {required this.name,
      required this.description,
      required this.price,
      this.urlImage});
}
