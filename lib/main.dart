import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/quotes.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/quotes': (context) => Quotes(),
    },
  ));
}
