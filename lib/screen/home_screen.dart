import 'package:flutter/material.dart';
import 'package:internet_store_tt/models/product_model.dart';
import 'package:internet_store_tt/screen/product_info_screen.dart';
import 'package:internet_store_tt/screen/shopping_cart_screen.dart';

import '../methods.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<Product> products = [
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
      description: 'Отличные беспроводные наушники с активным шумоподавлением.',
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
      description: 'Отличные беспроводные наушники с активным шумоподавлением.',
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
      description: 'Отличные беспроводные наушники с активным шумоподавлением.',
      price: 24999,
      urlImage: 'https://gamestore.kg/wp-content/uploads/wh100xm4-1.jpg',
    ),
  ];

  List<Product> buyProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Интернет магазин"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShoppingCartScreen(
                              buyProducts: buyProducts,
                            )),
                  );
                },
                icon: const Icon(Icons.shopping_cart)),
          ],
        ),
        body: GridView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 280,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductInfoScreen(
                                product: products[index],
                              )));
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
                            child: Image.network(products[index].urlImage ??
                                "https://www.lionstroy.ru/published/publicdata/U70619SHOP/attachments/SC/products_pictures/nophoto.png"),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          child: Text(
                            products[index].name,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          products[index].description,
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${formatNumberWithSpaces(products[index].price)} сом",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                buyProducts.add(products[index]);
                              },
                              child: const Text(
                                "Добавить в корзину",
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
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
