import 'package:baganbilash/Views/homePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp((MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'BaganBilash',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: MyHomePage(),
  )));
}
