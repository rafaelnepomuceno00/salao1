import 'package:flutter/material.dart';
import 'package:salao1/drawer/drawer_person.dart';
import 'package:salao1/helper/register_helper.dart';


class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {

  RegisterHelper helper = RegisterHelper();


  @override
  void initState() {
    super.initState();

    Register r = Register();
    r.name = 'rafael';
    r.value = '2132';

    helper.saveRegister(r);

    helper.getAllRegisters().then((list){
      print(list);
    } );

  }

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
