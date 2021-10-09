import 'package:books_app_up/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Books App and Up',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: const HomePage());
  }
}
