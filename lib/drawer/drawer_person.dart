import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salao1/pages/calendar.dart';
import 'package:salao1/pages/home_page.dart';


class DrawerPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(5),
                child: Image.network(
                  'https://i.pinimg.com/originals/96/25/b0/9625b070c83e437fa5c80016238f4171.png',
                ))
          ],
        ),
        ListTile(
          title: Text('home'),
          leading: Icon(
            Icons.home,
            color: Color.fromARGB(120, 120, 120, 120),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        Divider(
          color: Color.fromARGB(120, 120, 120, 120),
          endIndent: 10,
          indent: 10,
        ),
        ListTile(
            title: Text('Calendário'),
            leading: Icon(
              Icons.calendar_today,
              color: Color.fromARGB(120, 120, 120, 120),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Calendario()),
              );
            }),
        Divider(
          color: Color.fromARGB(120, 120, 120, 120),
          endIndent: 10,
          indent: 10,
        ),
      ],
    ));
  }
}
