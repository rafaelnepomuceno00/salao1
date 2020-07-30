import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawer/drawer_person.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(primaryColor: Colors.pink),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(
          'https://i.pinimg.com/originals/96/25/b0/9625b070c83e437fa5c80016238f4171.png',
          width: 150.0,
          height: 50.0,
        ),
        centerTitle: true,
      ),
      drawer: DrawerPerson(),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
