class BuyProduct{
  int? id;
  late int idProduct;

  static String buyProductTable = "BuyProduct";
  static String columnId = "id";
  static String columnIdProduct = "id_product";


  BuyProduct(this.idProduct);

  BuyProduct.fromMap(Map<String,dynamic> map){
    id = map[columnId];
    idProduct = map[columnIdProduct];
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = {};
    map[columnId] = id;
    map[columnIdProduct] = idProduct;
    return map;
  }
}