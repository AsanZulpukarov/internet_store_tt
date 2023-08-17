import 'package:internet_store_tt/data/models/buy_product_model.dart';
import 'package:internet_store_tt/data/storage/db/database.dart';

class BuyProductRepo {
  late final DBProvider _dbProvider;
  BuyProductRepo() {
    _dbProvider = DBProvider.db;
  }

  DBProvider get dbProvider => _dbProvider;

  Future<List<BuyProduct>> getBuyAllProducts() async {
    return await _dbProvider.getAllBuyProducts();
  }

  Future<BuyProduct> addProduct(BuyProduct product) {
    return _dbProvider.insertBuyProduct(product);
  }

  Future<int> deleteProduct(int id) async {
    return await _dbProvider.deleteBuyProduct(id);
  }
}
