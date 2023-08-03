import 'package:flutter/material.dart';
import 'package:internet_store_tt/models/product_model.dart';

import '../methods.dart';

class ProductInfoScreen extends StatelessWidget {
  Product product;
  ProductInfoScreen({Key? key, required this.product}) : super(key: key);

  TextStyle styleTitleText = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle styleSubTitleText =
      const TextStyle(fontSize: 16, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(40)),
              ),
              alignment: Alignment.center,
              height: 300,
              child: Image.network(product.urlImage ??
                  "https://www.lionstroy.ru/published/publicdata/U70619SHOP/attachments/SC/products_pictures/nophoto.png"),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    style: styleTitleText,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: SingleChildScrollView(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Описание: ",
                              style: styleTitleText,
                            ),
                            Text(
                              product.description,
                              style: styleSubTitleText,
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Цена:",
                        style: styleTitleText,
                      ),
                      Text(
                        "${formatNumberWithSpaces(product.price)} сом",
                        style: styleSubTitleText,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {}, child: const Text("Купить"))),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
