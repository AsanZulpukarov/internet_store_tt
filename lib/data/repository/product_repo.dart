import 'package:flutter/cupertino.dart';
import 'package:internet_store_tt/data/models/product_model.dart';
import 'package:internet_store_tt/data/storage/db/database.dart';

class ProductRepo {
  late final DBProvider _dbProvider;
  ProductRepo() {
    _dbProvider = DBProvider.db;
  }

  DBProvider get dbProvider => _dbProvider;

  Future<List<Product>> getProducts() async {
    return await _dbProvider.getProducts();
  }

  Future<Product> getOneProduct(int id) async {
    return await _dbProvider.getProduct(id);
  }

  Future<Product> addProduct(Product product) async {
    return await _dbProvider.insertProduct(product);
  }

  Future<void> updateProduct(Product product) async {
    await _dbProvider.updateProduct(product);
  }

  Future<int> deleteProduct(int id) async {
    return await _dbProvider.deleteProduct(id);
  }
}
