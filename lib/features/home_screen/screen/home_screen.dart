import 'package:flutter/material.dart';
import 'package:internet_store_tt/data/provider/app_provider.dart';
import 'package:provider/provider.dart';

import '../../../data/models/buy_product_model.dart';
import '../../../data/models/product_model.dart';
import '../../../methods.dart';
import '../../product_info_screen/screen/product_info_screen.dart';
import '../../shopping_cart_screen/screen/shopping_cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Product> _listProduct = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        _listProduct = appProvider.listProducts;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Интернет магазин"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ShoppingCartScreen();
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart)),
            ],
          ),
          body: GridView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: _listProduct.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 280,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              final product = _listProduct[index];

              return InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductInfoScreen(
                        id: product.id!,
                      ),
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network(product.urlImage ??
                                "https://www.lionstroy.ru/published/publicdata/U70619SHOP/attachments/SC/products_pictures/nophoto.png"),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          child: Text(
                            product.name,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          product.description,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${formatNumberWithSpaces(product.price)} сом",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              appProvider
                                  .addBuyProduct(BuyProduct(product.id!));
                            },
                            child: const Text(
                              "Добавить в корзину",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
/*
class HomeScreenInheritedWidget extends InheritedWidget {
  final List<Product> buyProducts;

  HomeScreenInheritedWidget(
      {Key? key, required Widget child, required this.buyProducts})
      : super(key: key, child: child) {
    print(buyProducts.length);
  }

  @override
  bool updateShouldNotify(HomeScreenInheritedWidget oldWidget) =>
      buyProducts.length != oldWidget.buyProducts.length;

  static HomeScreenInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}
*/
