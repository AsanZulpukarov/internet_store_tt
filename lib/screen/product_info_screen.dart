import 'package:flutter/material.dart';
import 'package:internet_store_tt/db/database.dart';
import 'package:internet_store_tt/models/product_model.dart';

import '../methods.dart';
import 'form_for_edit_product.dart';

class ProductInfoScreen extends StatefulWidget {
  final int id;
  const ProductInfoScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  TextStyle styleTitleText = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  TextStyle styleSubTitleText = const TextStyle(
    fontSize: 16,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: DBProvider.db.getProduct(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("Нет данных"),
              );
            }
            Product product = snapshot.data!;
            return SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(40)),
                          ),
                          alignment: Alignment.center,
                          height: 320,
                          child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.network(product.urlImage ??
                                  "https://www.lionstroy.ru/published/publicdata/U70619SHOP/attachments/SC/products_pictures/nophoto.png")),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProductScreen(
                                      product: product,
                                    ),
                                  ),
                                );
                                setState(() {});
                                // TODO: update product
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 30,
                              )),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
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
                            onPressed: () {
                              getDialogWindowForBuyProduct(context,
                                  formatNumberWithSpaces(product.price));
                            },
                            child: const Text("Купить"))),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
