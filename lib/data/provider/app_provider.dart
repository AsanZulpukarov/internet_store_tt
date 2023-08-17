import 'package:flutter/cupertino.dart';
import 'package:internet_store_tt/data/models/buy_product_model.dart';
import 'package:internet_store_tt/data/repository/buy_product_repo.dart';
import 'package:internet_store_tt/data/repository/product_repo.dart';

import '../models/product_model.dart';

class AppProvider extends ChangeNotifier {
  final ProductRepo _productRepo = ProductRepo();
  final BuyProductRepo _buyProductRepo = BuyProductRepo();
  List<Product> _listProducts = [];
  List<BuyProduct> _listBuyProducts = [];
  int _sumPrice = 0;

  List<Product> get listProducts => _listProducts;

  List<BuyProduct> get listBuyProducts => _listBuyProducts;

  int get sumPrice => _sumPrice;

  AppProvider() {
    initListProduct();
    initListBuyProduct();
    summa();
    notifyListeners();
  }

  initListProduct() async {
    _listProducts = await _productRepo.getProducts();
  }

  initListBuyProduct() async {
    _listBuyProducts = await _buyProductRepo.getBuyAllProducts();
  }

  Product getOneProduct(int id) {
    return _listProducts.firstWhere((element) => element.id == id);
  }

  Product getOneBuyProduct(int id) {
    BuyProduct buyProduct = _listBuyProducts.firstWhere(
      (element) => element.id == id,
    );

    return getOneProduct(buyProduct.idProduct);
  }

  addBuyProduct(BuyProduct buyProduct) async {
    _listBuyProducts.add(await _buyProductRepo.addProduct(buyProduct));
    notifyListeners();
  }

  updateProduct(Product product) async {
    await _productRepo.updateProduct(product);
    int index = _listProducts.indexWhere((product) => product.id == product.id);
    if (index != -1) {
      _listProducts[index] = product;
      notifyListeners();
    }
  }

  deleteBuyProduct(BuyProduct buyProduct) async {
    await _buyProductRepo.deleteProduct(buyProduct.id!);
    _listBuyProducts.removeWhere((element) => element.id == buyProduct.id);

    Product product = getOneBuyProduct(buyProduct.id!);
    afterUpdateSumPrice(product);
    notifyListeners();
  }

  summa() async {
    _sumPrice = 0;
    await Future.wait(
      _listBuyProducts.map(
        (element) async {
          Product product = getOneProduct(element.idProduct);
          _sumPrice += product.price;
        },
      ),
    );
    notifyListeners();
  }

  afterUpdateSumPrice(Product product) {
    _sumPrice -= product.price;
  }
}
