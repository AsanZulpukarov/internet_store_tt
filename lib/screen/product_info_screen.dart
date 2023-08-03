import 'package:flutter/material.dart';
import 'package:internet_store_tt/models/product_model.dart';

import '../methods.dart';

class ProductInfoScreen extends StatelessWidget {
  Product product;
  ProductInfoScreen({Key? key, required this.product}) : super(key: key);

  TextStyle styleTitleText =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white24,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                height: 200,
                child: Image.network(product.urlImage ??
                    "https://www.lionstroy.ru/published/publicdata/U70619SHOP/attachments/SC/products_pictures/nophoto.png"),
              ),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Card(
                  elevation: 2,
                  child: SingleChildScrollView(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Описание: ",
                            style: styleTitleText,
                          ),
                          Text("${product.description}"),
                        ],
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Цена:",
                    style: styleTitleText,
                  ),
                  Text("${formatNumberWithSpaces(product.price)} сом"),
                ],
              ),
              Center(
                  child:
                      ElevatedButton(onPressed: () {}, child: Text("купить"))),
            ],
          ),
        ),
      ),
    );
  }
}
