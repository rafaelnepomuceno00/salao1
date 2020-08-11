import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salao1/pages/home_page.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(primaryColor: Colors.pink),
    debugShowCheckedModeBanner: false,
  ));
}
