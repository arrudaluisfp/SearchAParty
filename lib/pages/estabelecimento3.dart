import 'package:flutter/material.dart';

class Estabelecimento3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('App Bar'),
        ),
        drawer: Drawer(),
        body: Center(
          child: Container(
            child: Text('ESTABELECIMENTO 3'),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            )
          ],
        ),
      ),
    );
  }
}