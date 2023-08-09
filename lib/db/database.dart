import 'dart:io';

import 'package:internet_store_tt/models/buy_product.dart';
import 'package:internet_store_tt/models/product_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static late Database _database;

  Future<Database> get database async {
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = "${dir.path}Internet_store.db";
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  _createDB(Database db, int version) async {
    List<Product> testProducts = [
      Product(
        name: 'Xiaomi Redmi 12 8+128Gb',
        description: 'Мощный смартфон с отличной камерой.',
        price: 15000,
        urlImage: 'https://www.myphone.kg/files/media/20/20883.webp',
      ),
      Product(
          name: 'Ноутбук Dell XPS 13',
          description:
              'Легкий и производительный ноутбук для работы и развлечений.',
          price: 120000,
          urlImage:
              'https://avatars.mds.yandex.net/get-mpic/4362548/img_id1555423894575553672.jpeg/orig'),
      Product(
        name: 'Наушники Sony WH-1000XM4',
        description:
            'Отличные беспроводные наушники с активным шумоподавлением.',
        price: 24999,
        urlImage: 'https://gamestore.kg/wp-content/uploads/wh100xm4-1.jpg',
      ),
      Product(
        name: 'Xiaomi Redmi 12 8+128Gb',
        description: 'Мощный смартфон с отличной камерой.',
        price: 15000,
        urlImage: 'https://www.myphone.kg/files/media/20/20883.webp',
      ),
      Product(
          name: 'Ноутбук Dell XPS 13',
          description:
              'Легкий и производительный ноутбук для работы и развлечений.',
          price: 120000,
          urlImage:
              'https://avatars.mds.yandex.net/get-mpic/4362548/img_id1555423894575553672.jpeg/orig'),
      Product(
        name: 'Наушники Sony WH-1000XM4',
        description:
            'Отличные беспроводные наушники с активным шумоподавлением.',
        price: 24999,
        urlImage: 'https://gamestore.kg/wp-content/uploads/wh100xm4-1.jpg',
      ),
      Product(
        name: 'Xiaomi Redmi 12 8+128Gb',
        description: 'Мощный смартфон с отличной камерой.',
        price: 15000,
        urlImage: 'https://www.myphone.kg/files/media/20/20883.webp',
      ),
      Product(
          name: 'Ноутбук Dell XPS 13',
          description:
              'Легкий и производительный ноутбук для работы и развлечений.',
          price: 120000,
          urlImage:
              'https://avatars.mds.yandex.net/get-mpic/4362548/img_id1555423894575553672.jpeg/orig'),
      Product(
        name: 'Наушники Sony WH-1000XM4',
        description:
            'Отличные беспроводные наушники с активным шумоподавлением.',
        price: 24999,
        urlImage: 'https://gamestore.kg/wp-content/uploads/wh100xm4-1.jpg',
      )
    ];
    await db.execute('''
        CREATE TABLE ${Product.productsTable}(
          ${Product.columnId} INTEGER PRIMARY KEY AUTOINCREMENT, 
          ${Product.columnName} TEXT, 
          ${Product.columnDescription} TEXT,
          ${Product.columnPrice} INTEGER, 
          ${Product.columnUrlImage} TEXT
        )
        ''');
    await db.execute('''
        CREATE TABLE ${BuyProduct.buyProductTable} (
          ${BuyProduct.columnId} INTEGER PRIMARY KEY AUTOINCREMENT, 
          ${BuyProduct.columnIdProduct} INTEGER, 
          FOREIGN KEY(${BuyProduct.columnIdProduct}) REFERENCES ${Product.productsTable} (${Product.columnId})
        )
        ''');
    for (var element in testProducts) {
      insertProduct(element).then((value) => value.id);
    }
  }

  //READ ALL PRODUCTS FROM PRODUCT
  Future<List<Product>> getProducts() async {
    Database db = await database;
    List<Map<String, dynamic>> productsMapList =
        await db.query(Product.productsTable);
    List<Product> products = [];
    for (var element in productsMapList) {
      products.add(Product.fromMap(element));
    }

    return products;
  }

  //READ ONE PRODUCT FROM PRODUCT
  Future<Product> getProduct(int id) async {
    Database db = await database;
    var res = await db.query(Product.productsTable,
        where: "${Product.columnId} = ?", whereArgs: [id]);

    return Product.fromMap(res.first);
  }

  //READ ALL PRODUCT FROM BUY_PRODUCT
  Future<List<BuyProduct>> getAllBuyProducts() async {
    Database db = await database;
    List<Map<String, dynamic>> buyProductMapList =
        await db.query(BuyProduct.buyProductTable);
    List<BuyProduct> buyProductList = [];
    for (var element in buyProductMapList) {
      buyProductList.add(BuyProduct.fromMap(element));
    }

    return buyProductList;
  }

  //READ ONE PRODUCT FROM BUY_PRODUCT
  Future<BuyProduct?> getBuyProduct(int id) async {
    Database db = await database;
    var res = await db.query(Product.productsTable,
        where: "${BuyProduct.columnId} = ?", whereArgs: [id]);

    return res.isNotEmpty ? BuyProduct.fromMap(res.first) : null;
  }

  //INSERT TO PRODUCT
  Future<Product> insertProduct(Product product) async {
    Database db = await database;
    product.id = await db.insert(Product.productsTable, product.toMap());

    return product;
  }

  //INSERT TO BUY_PRODUCT
  Future<BuyProduct> insertBuyProduct(BuyProduct product) async {
    Database db = await database;
    product.id = await db.insert(BuyProduct.buyProductTable, product.toMap());

    return product;
  }

  //UPDATE
  Future<int> updateProduct(Product product) async {
    Database db = await database;
    var res = await db.update(
      Product.productsTable,
      product.toMap(),
      where: "${Product.columnId} = ?",
      whereArgs: [product.id],
    );

    return res;
  }

  //DELETE FROM PRODUCT
  Future<int> deleteProduct(int id) async {
    Database db = await database;
    var res = await db.delete(
      Product.productsTable,
      where: "${Product.columnId} = ?",
      whereArgs: [id],
    );

    return res;
  }

  //DELETE FROM BUY_PRODUCT
  Future<int> deleteBuyProduct(int id) async {
    Database db = await database;
    var res = await db.delete(
      BuyProduct.buyProductTable,
      where: "${BuyProduct.columnId} = ?",
      whereArgs: [id],
    );

    return res;
  }
}
