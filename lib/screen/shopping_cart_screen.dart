import 'package:flutter/material.dart';
import 'package:internet_store_tt/models/data_storage.dart';
import 'package:internet_store_tt/screen/product_info_screen.dart';

import '../methods.dart';
import '../models/product_model.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  int sum = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sumProducts();
  }

  void sumProducts() {
    sum = 0;
    for (var element in DataStorage().buyProductsIndex) {
      sum += DataStorage().products[element].price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Корзина"),
      ),
      body: DataStorage().buyProductsIndex.isEmpty
          ? const Center(child: Text("Нет товара в корзине."))
          : Stack(
              alignment: Alignment.center,
              children: [
                ListView.separated(
                  itemCount: DataStorage().buyProductsIndex.length,
                  itemBuilder: (context, int index) {
                    Product item = DataStorage()
                        .products[DataStorage().buyProductsIndex[index]];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductInfoScreen(
                                      index:
                                          DataStorage().buyProductsIndex[index],
                                    )));
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
                        onPressed: () {
                          DataStorage().buyProductsIndex.removeAt(index);
                          sumProducts();
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('${item.name} удалено из корзины.')),
                          );
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.white,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 10,
                      color: Colors.black,
                    );
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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 20,
                    child: DataStorage().buyProductsIndex.isEmpty
                        ? Container()
                        : ElevatedButton(
                            onPressed: () {
                              getDialogWindowForBuyProduct(
                                  context, formatNumberWithSpaces(sum));
                            },
                            child: const Text("Оформить заказ"))),
              ],
            ),
    );
  }
}
