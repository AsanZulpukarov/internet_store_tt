import 'package:flutter/material.dart';
import 'package:internet_store_tt/theme.dart';

import 'screen/home_screen.dart';

void main() {
  runApp(const InternetStoreApp());
}

class InternetStoreApp extends StatelessWidget {
  const InternetStoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
