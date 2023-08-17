class Product {
  int? id;
  late String _name;
  late String _description;
  late int _price;
  late String? _urlImage;

  String get name => _name;
  static String productsTable = "Products";
  static String columnId = "id";
  static String columnName = "_name";
  static String columnDescription = "_description";
  static String columnPrice = "_price";
  static String columnUrlImage = "_urlImage";

  Product(this._name, this._description, this._price, this._urlImage,
      {this.id});

  Product.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    _name = map[columnName];
    _description = map[columnDescription];
    _price = map[columnPrice];
    _urlImage = map[columnUrlImage];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map[columnId] = id;
    map[columnName] = _name;
    map[columnDescription] = _description;
    map[columnPrice] = _price;
    map[columnUrlImage] = _urlImage;
    return map;
  }

  String get description => _description;

  int get price => _price;

  String? get urlImage => _urlImage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          _name == other._name &&
          _description == other._description &&
          _price == other._price &&
          _urlImage == other._urlImage;

  @override
  int get hashCode =>
      id.hashCode ^
      _name.hashCode ^
      _description.hashCode ^
      _price.hashCode ^
      _urlImage.hashCode;

  @override
  String toString() {
    return 'Product{id: $id, _name: $_name, _description: $_description, _price: $_price}';
  }
}
