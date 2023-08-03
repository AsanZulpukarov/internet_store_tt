import 'package:flutter/material.dart';
import 'package:internet_store_tt/screen/product_info_screen.dart';

import '../methods.dart';
import '../models/product_model.dart';

class ShoppingCartScreen extends StatefulWidget {
  List<Product> buyProducts;

  ShoppingCartScreen({Key? key, required this.buyProducts}) : super(key: key);

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
    for (var element in widget.buyProducts) {
      sum += element.price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Корзина"),
      ),
      body: widget.buyProducts.isEmpty
          ? const Center(child: Text("Нет товара в корзине."))
          : Stack(
              alignment: Alignment.center,
              children: [
                ListView.separated(
                  itemCount: widget.buyProducts.length,
                  itemBuilder: (context, int index) {
                    Product item = widget.buyProducts[index];
                    return Dismissible(
                      key: Key(index.toString()),
                      onDismissed: (direction) {
                        widget.buyProducts.removeAt(index);
                        sumProducts();
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('${item.name} удалено из корзины.')),
                        );
                      },
                      direction: DismissDirection.endToStart,
                      background: Container(
                        padding: const EdgeInsets.only(right: 20),
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductInfoScreen(
                                        product: item,
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
                        trailing: ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              "Купить",
                              style: TextStyle(fontSize: 10),
                            )),
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
                    child: widget.buyProducts.isEmpty
                        ? Container()
                        : ElevatedButton(
                            onPressed: () {},
                            child: const Text("Оформить заказ"))),
              ],
            ),
    );
  }
}
