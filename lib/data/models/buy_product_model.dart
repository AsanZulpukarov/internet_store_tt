class BuyProduct {
  int? id;
  late int _idProduct;

  int get idProduct => _idProduct;

  static String buyProductTable = "BuyProduct";
  static String columnId = "id";
  static String columnIdProduct = "id_product";

  BuyProduct(this._idProduct);

  BuyProduct.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    _idProduct = map[columnIdProduct];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map[columnId] = id;
    map[columnIdProduct] = _idProduct;
    return map;
  }

  @override
  String toString() {
    return 'BuyProduct{id: $id, _idProduct: $_idProduct}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuyProduct &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          _idProduct == other._idProduct;

  @override
  int get hashCode => id.hashCode ^ _idProduct.hashCode;
}
