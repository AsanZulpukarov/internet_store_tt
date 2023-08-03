import 'package:flutter/material.dart';

import 'screen/home_screen.dart';

main() {
  runApp(const InternetStoreApp());
}

class InternetStoreApp extends StatelessWidget {
  const InternetStoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
