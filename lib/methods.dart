import 'package:flutter/material.dart';

String formatNumberWithSpaces(int number) {
  String numberString = number.toString();
  RegExp regExp = RegExp(r'\d{1,3}(?=(\d{3})+(?!\d))');
  // Замена каждых трех символов с пробелами
  String formattedNumber = numberString.replaceAllMapped(
      regExp, (Match match) => '${match.group(0)} ');
  return formattedNumber;
}

void getDialogWindowForBuyProduct(BuildContext context, String sum) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Ваш заказ успешно оформлен!"),
        content: Text('Сумма товара $sum сом'),
        actions: [
          ElevatedButton(
            child: const Text('ОК'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
