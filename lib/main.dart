import 'package:flutter/material.dart';
import 'package:internet_store_tt/data/provider/app_provider.dart';
import 'package:internet_store_tt/theme.dart';
import 'package:provider/provider.dart';

import 'features/home_screen/screen/home_screen.dart';

void main() {
  runApp(const InternetStoreApp());
}

class InternetStoreApp extends StatelessWidget {
  const InternetStoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
