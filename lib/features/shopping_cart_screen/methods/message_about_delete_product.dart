import 'package:flutter/material.dart';

void messageAboutDeleteProduct(BuildContext context , String name) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$name удалено из корзины.'),
    ),
  );
}