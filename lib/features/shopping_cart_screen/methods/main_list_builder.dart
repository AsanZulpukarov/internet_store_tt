import 'package:flutter/material.dart';
import 'package:internet_store_tt/data/provider/app_provider.dart';
import 'package:provider/provider.dart';

import '../../../data/models/buy_product_model.dart';
import '../../../data/models/product_model.dart';
import '../../../methods.dart';
import '../../product_info_screen/screen/product_info_screen.dart';
import 'message_about_delete_product.dart';

class ListBuilderShoppingCart extends StatelessWidget {
  ListBuilderShoppingCart({Key? key}) : super(key: key);

  late int sum = 0;

  late List<BuyProduct> buyProducts;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        appProvider.summa();
        sum = appProvider.sumPrice;
        buyProducts = appProvider.listBuyProducts;
        return buyProducts.isEmpty
            ? const Center(
                child: Text("Нет товара"),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  ListView.separated(
                    itemCount: buyProducts.length,
                    itemBuilder: (context, int index) {
                      Product item =
                          appProvider.getOneBuyProduct(buyProducts[index].id!);
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
                          onPressed: () {
                            appProvider.deleteBuyProduct(buyProducts[index]);
                            messageAboutDeleteProduct(context, item.name);
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
      },
    );
  }
}
