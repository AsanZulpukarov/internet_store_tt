import 'package:flutter/material.dart';
import 'package:internet_store_tt/db/database.dart';
import 'package:internet_store_tt/models/buy_product.dart';
import 'package:internet_store_tt/screen/product_info_screen.dart';

import '../methods.dart';
import '../models/product_model.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  int sum = 0;

  @override
  void initState() {
    super.initState();
    sumProducts();
  }

  Future<int> sumProducts() async {
    List<BuyProduct> buyProducts = await DBProvider.db.getAllBuyProducts();
    int totalSum = 0;

    await Future.wait(buyProducts.map((element) async {
      Product n = await DBProvider.db.getProduct(element.idProduct);
      totalSum += n.price;
    }));

    sum = totalSum;
    return sum;
  }

  void messageAboutDeleteProduct(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name удалено из корзины.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Корзина"),
      ),
      body: FutureBuilder(
        future: sumProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Ошибка"));
          } else {
            return buildShoppingCartWidget();
          }
        },
      ),
    );
  }

  Widget buildShoppingCartWidget() {
    return Stack(
      alignment: Alignment.center,
      children: [
        FutureBuilder<List<BuyProduct>>(
          future: DBProvider.db.getAllBuyProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<BuyProduct> buyProducts = snapshot.data!;
              return ListView.separated(
                itemCount: buyProducts.length,
                itemBuilder: (context, int index) {
                  return FutureBuilder<Product>(
                    future:
                        DBProvider.db.getProduct(buyProducts[index].idProduct),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Ошибка загрузки товара");
                      } else if (!snapshot.hasData) {
                        return const Text("Товар не найден");
                      }

                      Product item = snapshot.data!;
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductInfoScreen(
                                  id: buyProducts[index].idProduct),
                            ),
                          );
                        },
                        leading: Container(
                          alignment: Alignment.center,
                          color: Colors.white,
                          width: 80,
                          height: 80,
                          child: Image.network(item.urlImage ??
                              "https://www.lionstroy.ru/published/publicdata/U70619SHOP/attachments/SC/products_pictures/nophoto.png"),
                        ),
                        title: Text(
                          item.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          "${formatNumberWithSpaces(item.price)} сом",
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            await DBProvider.db
                                .deleteBuyProduct(buyProducts[index].id!);
                            await sumProducts();
                            setState(() {});
                            messageAboutDeleteProduct(item.name);
                          },
                          icon: const Icon(Icons.delete),
                          color: Colors.white,
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 10,
                    color: Colors.black,
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Нет товара в корзине"));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        Positioned(
          bottom: 80,
          child: Card(
            color: Theme.of(context).primaryColor,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Общая сумма: ${formatNumberWithSpaces(sum)} сом",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        sum != 0
            ? Positioned(
                bottom: 30,
                child: ElevatedButton(
                  onPressed: () {
                    getDialogWindowForBuyProduct(
                        context, formatNumberWithSpaces(sum));
                  },
                  child: const Text("Оформить заказ"),
                ),
              )
            : Container(),
      ],
    );
  }
}
