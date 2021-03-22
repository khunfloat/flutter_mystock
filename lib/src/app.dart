import 'package:flutter/material.dart';
import 'package:my_stock/src/pages/home/home_page.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomePage(title: 'flutter my stock test first time.'),
    );
  }
}